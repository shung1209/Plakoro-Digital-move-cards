import { createServer } from "node:http";
import { randomBytes } from "node:crypto";
import { WebSocket, WebSocketServer } from "ws";

const PORT = Number.parseInt(process.env.PORT ?? "10000", 10);
const rooms = new Map();
const HEARTBEAT_MS = 25000;
const ROOM_TTL_MS = 30 * 60 * 1000;
const server = createServer((_request, response) => {
  response.writeHead(200, { "content-type": "application/json" });
  response.end(JSON.stringify({ ok: true, service: "plakoro-digital-relay", protocol: 1, rooms: rooms.size }));
});
const wss = new WebSocketServer({ server, path: "/ws" });

wss.on("connection", (socket) => {
  const client = { id: randomBytes(8).toString("hex"), token: randomBytes(24).toString("hex"), name: "Player", roomCode: null, connected: true, socket };
  socket.isAlive = true;
  send(socket, { type: "connected", player_id: client.id, reconnect_token: client.token, protocol: 1 });
  socket.on("pong", () => { socket.isAlive = true; });
  socket.on("message", (data) => receive(client, data));
  socket.on("close", () => disconnect(client));
  socket.on("error", () => {});
});

function receive(client, data) {
  let message;
  try { message = JSON.parse(data.toString("utf8")); }
  catch { return fail(client, "invalid_json", "Message must be valid JSON."); }
  switch (message.type) {
    case "create_room": return createRoom(client, cleanName(message.player_name));
    case "join_room": return joinRoom(client, cleanCode(message.room_code), cleanName(message.player_name));
    case "leave_room": return leaveRoom(client);
    case "resume_session": return resume(client, String(message.reconnect_token ?? ""));
    case "publish_move": return publishMove(client, message.payload);
    case "decide_first": return decideFirst(client, String(message.mode ?? ""), String(message.choice ?? ""));
    case "set_ready": return setReady(client, Boolean(message.ready), message.loadout);
    case "ping": return send(client.socket, { type: "pong", sent_at: message.sent_at ?? null });
    default: return fail(client, "unknown_message", "Unknown message type.");
  }
}

function createRoom(client, name) {
  leaveRoom(client, false);
  let code = createCode(); while (rooms.has(code)) code = createCode();
  const room = { code, hostId: client.id, players: new Map(), updatedAt: Date.now(), firstPlayerId: null, initiativeMode: null, rpsChoices: new Map(), readyPlayers: new Map(), matchStarted: false };
  rooms.set(code, room); addPlayer(room, client, name);
  send(client.socket, { type: "room_joined", room: serialize(room) }); broadcastRoom(room);
}
function joinRoom(client, code, name) {
  const room = rooms.get(code);
  if (!room) return fail(client, "room_not_found", "Room not found.");
  if (room.players.size >= 2 && !room.players.has(client.id)) return fail(client, "room_full", "Room is full.");
  leaveRoom(client, false); addPlayer(room, client, name);
  send(client.socket, { type: "room_joined", room: serialize(room) }); broadcastRoom(room);
}
function addPlayer(room, client, name) {
  client.name = name; client.roomCode = room.code; client.connected = true;
  room.players.set(client.id, client); room.firstPlayerId = null; room.initiativeMode = null; room.rpsChoices.clear(); room.readyPlayers.clear(); room.matchStarted = false; room.updatedAt = Date.now();
}
function publishMove(client, input) {
  const room = rooms.get(client.roomCode);
  if (!room || !room.players.has(client.id)) return fail(client, "not_in_room", "Join a room first.");
  if (room.players.size !== 2) return fail(client, "waiting_for_opponent", "Waiting for the second player.");
  const payload = sanitizeMove(input);
  if (!payload.move_id) return fail(client, "invalid_move", "Move ID is required.");
  payload.sender_id = client.id;
  room.updatedAt = Date.now();
  for (const player of room.players.values()) if (player.id !== client.id && player.connected) send(player.socket, { type: "opponent_move", payload });
}
function decideFirst(client, mode, choice) {
  const room = rooms.get(client.roomCode);
  if (!room || !room.players.has(client.id)) return fail(client, "not_in_room", "Join a room first.");
  const connected = [...room.players.values()].filter((p) => p.connected);
  if (connected.length !== 2) return fail(client, "waiting_for_opponent", "Waiting for the second player.");
  if (room.firstPlayerId) return send(client.socket, { type: "initiative_result", result: initiativeResult(room) });
  if (mode === "coin") {
    room.initiativeMode = "coin";
    room.firstPlayerId = connected[Math.floor(Math.random() * connected.length)].id;
    room.updatedAt = Date.now();
    return broadcast(room, { type: "initiative_result", result: initiativeResult(room) });
  }
  if (mode !== "rps" || !["rock", "paper", "scissors"].includes(choice)) return fail(client, "invalid_initiative", "Choose coin flip or a valid RPS hand.");
  room.initiativeMode = "rps"; room.rpsChoices.set(client.id, choice); room.updatedAt = Date.now();
  if (room.rpsChoices.size < 2) return send(client.socket, { type: "initiative_waiting", mode: "rps" });
  const [a, b] = connected;
  const first = room.rpsChoices.get(a.id), second = room.rpsChoices.get(b.id);
  if (first === second) {
    room.rpsChoices.clear();
    return broadcast(room, { type: "initiative_tie", mode: "rps" });
  }
  const wins = (x, y) => (x === "rock" && y === "scissors") || (x === "paper" && y === "rock") || (x === "scissors" && y === "paper");
  room.firstPlayerId = wins(first, second) ? a.id : b.id;
  const choices = Object.fromEntries(room.rpsChoices); room.rpsChoices.clear();
  broadcast(room, { type: "initiative_result", result: { ...initiativeResult(room), choices } });
}
function initiativeResult(room) { return { mode: room.initiativeMode, first_player_id: room.firstPlayerId }; }
function setReady(client, ready, rawLoadout) {
  const room = rooms.get(client.roomCode);
  if (!room || !room.players.has(client.id)) return fail(client, "not_in_room", "Join a room first.");
  if (ready) {
    if (!room.firstPlayerId) return fail(client, "initiative_required", "Decide who goes first before readying.");
    room.readyPlayers.set(client.id, sanitizeLoadout(rawLoadout));
  } else {
    room.readyPlayers.delete(client.id); room.matchStarted = false;
  }
  room.updatedAt = Date.now(); broadcastRoom(room);
  if (!room.matchStarted && room.readyPlayers.size === 2 && [...room.players.values()].filter((p) => p.connected).length === 2) {
    room.matchStarted = true;
    broadcast(room, { type: "battle_ready", match: { first_player_id: room.firstPlayerId, players: Object.fromEntries(room.readyPlayers) } });
  }
}
function sanitizeLoadout(value) {
  value = value && typeof value === "object" && !Array.isArray(value) ? value : {};
  return { pokemon_id: String(value.pokemon_id ?? "").slice(0, 100), move_ids: Array.isArray(value.move_ids) ? value.move_ids.slice(0, 4).map((id) => String(id).slice(0, 100)) : [] };
}
function sanitizeMove(input) {
  input = input && typeof input === "object" && !Array.isArray(input) ? input : {};
  const orientations = new Set(["", "ENEKORO_FAILED", "FACE_DOWN", "FACE_UP", "HEAD_UP", "HEAD_DOWN", "HEAD_LEFT", "HEAD_RIGHT"]);
  const orientation = String(input.orientation ?? "");
  return { protocol: 1, sequence: Math.max(0, Number.parseInt(input.sequence ?? 0, 10) || 0), move_id: String(input.move_id ?? "").slice(0, 100), pokemon_id: String(input.pokemon_id ?? "").slice(0, 100), orientation: orientations.has(orientation) ? orientation : "", move_failed: Boolean(input.move_failed), total_damage: input.total_damage === null ? null : Math.max(0, Number(input.total_damage) || 0), details: sanitizeDetails(input.details) };
}
function sanitizeDetails(data) {
  data = data && typeof data === "object" && !Array.isArray(data) ? data : {};
  return { self_damage: Math.max(0, Number.parseInt(data.self_damage ?? 0, 10) || 0), self_heal: Math.max(0, Number.parseInt(data.self_heal ?? 0, 10) || 0), incoming_reduction: Math.max(0, Number.parseInt(data.incoming_reduction ?? 0, 10) || 0), incoming_immunity: Boolean(data.incoming_immunity) };
}
function resume(client, token) {
  let previous, room;
  for (const candidate of rooms.values()) { previous = [...candidate.players.values()].find((p) => p.token === token && !p.connected); if (previous) { room = candidate; break; } }
  if (!previous || !room) return fail(client, "resume_failed", "Session is no longer available.");
  client.id = previous.id; client.token = previous.token; client.name = previous.name; client.roomCode = room.code; client.connected = true;
  room.players.set(client.id, client);
  send(client.socket, { type: "session_resumed", player_id: client.id, reconnect_token: client.token });
  send(client.socket, { type: "room_joined", room: serialize(room) }); broadcastRoom(room);
}
function leaveRoom(client, notify = true) {
  const room = rooms.get(client.roomCode);
  if (room) {
    room.players.delete(client.id); room.firstPlayerId = null; room.initiativeMode = null; room.rpsChoices.clear(); room.readyPlayers.clear(); room.matchStarted = false; room.updatedAt = Date.now();
    if (room.players.size === 0) rooms.delete(room.code);
    else { if (room.hostId === client.id) room.hostId = room.players.keys().next().value; broadcastRoom(room); }
  }
  client.roomCode = null; if (notify) send(client.socket, { type: "room_left" });
}
function disconnect(client) { client.connected = false; const room = rooms.get(client.roomCode); if (room) { room.updatedAt = Date.now(); broadcastRoom(room); } }
function serialize(room) { return { code: room.code, host_id: room.hostId, first_player_id: room.firstPlayerId, initiative_mode: room.initiativeMode, ready_count: room.readyPlayers.size, ready_player_ids: [...room.readyPlayers.keys()], match_started: room.matchStarted, player_count: room.players.size, connected_count: [...room.players.values()].filter((p) => p.connected).length, players: [...room.players.values()].map((p) => ({ id: p.id, name: p.name, connected: p.connected })) }; }
function broadcastRoom(room) { const payload = { type: "room_updated", room: serialize(room) }; for (const p of room.players.values()) if (p.connected) send(p.socket, payload); }
function broadcast(room, payload) { for (const p of room.players.values()) if (p.connected) send(p.socket, payload); }
function createCode() { return randomBytes(3).toString("hex").toUpperCase(); }
function cleanCode(v) { return String(v ?? "").replace(/[^A-F0-9]/gi, "").toUpperCase().slice(0, 6); }
function cleanName(v) { return String(v ?? "Player").trim().slice(0, 24) || "Player"; }
function send(socket, payload) { if (socket.readyState === WebSocket.OPEN) socket.send(JSON.stringify(payload)); }
function fail(client, code, message) { send(client.socket, { type: "error", code, message }); }

setInterval(() => {
  for (const socket of wss.clients) { if (socket.isAlive === false) socket.terminate(); else { socket.isAlive = false; socket.ping(); } }
  const cutoff = Date.now() - ROOM_TTL_MS; for (const [code, room] of rooms) if (room.updatedAt < cutoff) rooms.delete(code);
}, HEARTBEAT_MS).unref();
server.listen(PORT, "0.0.0.0", () => console.log(`Plakoro digital relay listening on ${PORT}`));
