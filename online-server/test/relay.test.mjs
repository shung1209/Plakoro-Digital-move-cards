import assert from "node:assert/strict";
import { spawn } from "node:child_process";
import { after, before, test } from "node:test";
import WebSocket from "ws";

const PORT = 10117;
const SOCKET_URL = `ws://127.0.0.1:${PORT}/ws`;
let relay;

const message = (socket, type, predicate = () => true) => new Promise((resolve, reject) => {
  const timer = setTimeout(() => reject(new Error(`Timed out waiting for ${type}`)), 4000);
  const handler = (raw) => {
    const value = JSON.parse(raw.toString());
    if (value.type !== type || !predicate(value)) return;
    clearTimeout(timer); socket.off("message", handler); resolve(value);
  };
  socket.on("message", handler);
});
const connect = async () => {
  const socket = new WebSocket(SOCKET_URL);
  const connectedMessage = message(socket, "connected");
  await new Promise((resolve, reject) => { socket.once("open", resolve); socket.once("error", reject); });
  return { socket, connected: await connectedMessage };
};
const createPair = async () => {
  const first = await connect();
  first.socket.send(JSON.stringify({ type: "create_room", player_name: "A" }));
  const joined = await message(first.socket, "room_joined");
  assert.match(joined.room.code, /^[A-I]{6}$/);
  const second = await connect();
  second.socket.send(JSON.stringify({ type: "join_room", room_code: joined.room.code, player_name: "B" }));
  await message(second.socket, "room_joined");
  return { first, second, code: joined.room.code };
};

before(async () => {
  relay = spawn(process.execPath, ["src/server.js"], { cwd: new URL("..", import.meta.url), env: { ...process.env, PORT: String(PORT) } });
  await new Promise((resolve, reject) => {
    const timer = setTimeout(() => reject(new Error("Relay did not start")), 4000);
    relay.stdout.on("data", (chunk) => { if (chunk.toString().includes("listening")) { clearTimeout(timer); resolve(); } });
    relay.once("exit", (code) => reject(new Error(`Relay exited with ${code}`)));
  });
});
after(() => relay?.kill("SIGTERM"));

test("energy room, coin initiative, readiness, turn order, and move relay", async () => {
  const { first, second } = await createPair();
  const coinA = message(first.socket, "initiative_result");
  const coinB = message(second.socket, "initiative_result");
  first.socket.send(JSON.stringify({ type: "decide_first", mode: "coin" }));
  const [a, b] = await Promise.all([coinA, coinB]);
  assert.equal(a.result.first_player_id, b.result.first_player_id);
  first.socket.send(JSON.stringify({ type: "set_ready", ready: true, loadout: { pokemon_id: "articuno", move_ids: ["1","2","3","4"] } }));
  const readyA = message(first.socket, "battle_ready"), readyB = message(second.socket, "battle_ready");
  second.socket.send(JSON.stringify({ type: "set_ready", ready: true, loadout: { pokemon_id: "squirtle", move_ids: ["5","6","7","8"] } }));
  await Promise.all([readyA, readyB]);
  const actor = a.result.first_player_id === first.connected.player_id ? first.socket : second.socket;
  const defender = actor === first.socket ? second.socket : first.socket;
  const rejected = message(defender, "error");
  defender.send(JSON.stringify({ type: "publish_move", payload: { sequence: 1, move_id: "wrong" } }));
  assert.equal((await rejected).code, "not_your_turn");
  const incoming = message(defender, "opponent_move");
  actor.send(JSON.stringify({ type: "publish_move", payload: { sequence: 1, move_id: "articuno_air_cutter_ebw01_024", pokemon_id: "articuno", orientation: "HEAD_UP", total_damage: 70, details: { self_damage: 10 } } }));
  const result = await incoming;
  assert.equal(result.payload.total_damage, 70);
  assert.equal(result.payload.details.self_damage, 10);
  first.socket.close(); second.socket.close();
});

test("rock-paper-scissors ties and then resolves privately", async () => {
  const { first, second } = await createPair();
  const tieA = message(first.socket, "initiative_tie"), tieB = message(second.socket, "initiative_tie");
  const waiting = message(first.socket, "initiative_waiting");
  first.socket.send(JSON.stringify({ type: "decide_first", mode: "rps", choice: "rock" })); await waiting;
  second.socket.send(JSON.stringify({ type: "decide_first", mode: "rps", choice: "rock" })); await Promise.all([tieA, tieB]);
  const resultA = message(first.socket, "initiative_result"), resultB = message(second.socket, "initiative_result");
  const waitingAgain = message(first.socket, "initiative_waiting");
  first.socket.send(JSON.stringify({ type: "decide_first", mode: "rps", choice: "paper" })); await waitingAgain;
  second.socket.send(JSON.stringify({ type: "decide_first", mode: "rps", choice: "rock" }));
  const [a, b] = await Promise.all([resultA, resultB]);
  assert.equal(a.result.first_player_id, first.connected.player_id);
  assert.equal(a.result.first_player_id, b.result.first_player_id);
  first.socket.close(); second.socket.close();
});
