extends Node

signal connection_changed(state: StringName)
signal room_changed(room: Dictionary)
signal opponent_move_received(payload: Dictionary)
signal initiative_changed(result: Dictionary)
signal battle_ready(result: Dictionary)
signal online_error(message: String)

const SERVER_SETTING := "online/server_url"
const DEFAULT_SERVER_URL := "ws://127.0.0.1:10000/ws"
const HEARTBEAT_MSEC := 20000
const RECONNECT_DELAYS: Array[int] = [500, 1500, 3000, 5000]

var socket := WebSocketPeer.new()
var state: StringName = &"disconnected"
var player_id := ""
var room: Dictionary = {}
var reconnect_token := ""
var resume_token := ""
var server_url := ""
var intentional_disconnect := false
var reconnect_attempt := 0
var reconnect_at := 0
var last_heartbeat := 0
var received_sequences: Dictionary = {}


func _ready() -> void:
	set_process(false)


func default_server_url() -> String:
	return String(ProjectSettings.get_setting(SERVER_SETTING, DEFAULT_SERVER_URL))


func connect_to_server(url := "") -> Error:
	if state != &"disconnected": disconnect_from_server()
	server_url = url.strip_edges() if not url.strip_edges().is_empty() else default_server_url()
	intentional_disconnect = false
	resume_token = ""
	reconnect_attempt = 0
	return _open_socket()


func _open_socket() -> Error:
	socket = WebSocketPeer.new()
	var error := socket.connect_to_url(server_url)
	if error != OK:
		_schedule_reconnect_or_close(error_string(error))
		return error
	_set_state(&"connecting")
	set_process(true)
	return OK


func disconnect_from_server() -> void:
	intentional_disconnect = true
	if socket.get_ready_state() != WebSocketPeer.STATE_CLOSED:
		socket.close(1000, "Client closed")
	_clear_session()
	set_process(false)
	_set_state(&"disconnected")


func create_room(player_name: String) -> void:
	_send({"type":"create_room", "player_name":player_name})


func join_room(code: String, player_name: String) -> void:
	_send({"type":"join_room", "room_code":code.strip_edges().to_upper(), "player_name":player_name})


func leave_room() -> void:
	_send({"type":"leave_room"})
	room.clear()
	room_changed.emit(room)


func publish_move(payload: Dictionary) -> void:
	_send({"type":"publish_move", "payload":payload})


func request_coin_flip() -> void:
	_send({"type":"decide_first", "mode":"coin"})


func submit_rps(choice: String) -> void:
	_send({"type":"decide_first", "mode":"rps", "choice":choice})


func set_battle_ready(ready: bool, loadout: Dictionary = {}) -> void:
	_send({"type":"set_ready", "ready":ready, "loadout":loadout})


func is_ready_for_moves() -> bool:
	return state == &"connected" and room.size() > 0 and int(room.get("connected_count", room.get("player_count", 0))) == 2


func is_room_host() -> bool:
	return not player_id.is_empty() and player_id == String(room.get("host_id", ""))


func reset_move_history() -> void:
	received_sequences.clear()


func _process(_delta: float) -> void:
	if state == &"reconnecting":
		if Time.get_ticks_msec() >= reconnect_at: _open_socket()
		return
	socket.poll()
	match socket.get_ready_state():
		WebSocketPeer.STATE_OPEN:
			if state != &"connected" and resume_token.is_empty(): _set_state(&"connected")
			while socket.get_available_packet_count() > 0: _receive(socket.get_packet())
			var now := Time.get_ticks_msec()
			if now - last_heartbeat >= HEARTBEAT_MSEC:
				last_heartbeat = now
				_send({"type":"ping", "sent_at":now})
		WebSocketPeer.STATE_CLOSED:
			if not intentional_disconnect and not reconnect_token.is_empty() and not room.is_empty():
				resume_token = reconnect_token
				_schedule_reconnect_or_close(socket.get_close_reason())
			else:
				_clear_session(); set_process(false); _set_state(&"disconnected")


func _receive(packet: PackedByteArray) -> void:
	var parsed: Variant = JSON.parse_string(packet.get_string_from_utf8())
	if not parsed is Dictionary:
		online_error.emit("Invalid server message")
		return
	var message := parsed as Dictionary
	match String(message.get("type", "")):
		"connected":
			player_id = String(message.get("player_id", ""))
			reconnect_token = String(message.get("reconnect_token", ""))
			if not resume_token.is_empty(): _send({"type":"resume_session", "reconnect_token":resume_token})
		"session_resumed":
			player_id = String(message.get("player_id", ""))
			reconnect_token = String(message.get("reconnect_token", resume_token))
			resume_token = ""; reconnect_attempt = 0; _set_state(&"connected")
		"room_joined", "room_updated":
			room = Dictionary(message.get("room", {})).duplicate(true)
			room_changed.emit(room)
		"room_left", "room_expired":
			room.clear(); room_changed.emit(room)
		"opponent_move":
			var payload := Dictionary(message.get("payload", {})).duplicate(true)
			var sender_id := String(payload.get("sender_id", "opponent"))
			var sequence := int(payload.get("sequence", 0))
			if sequence > int(received_sequences.get(sender_id, -1)):
				received_sequences[sender_id] = sequence
				opponent_move_received.emit(payload)
		"initiative_result":
			var result := Dictionary(message.get("result", {})).duplicate(true)
			room["first_player_id"] = String(result.get("first_player_id", ""))
			room["initiative_mode"] = String(result.get("mode", ""))
			initiative_changed.emit(result)
			room_changed.emit(room)
		"initiative_waiting", "initiative_tie":
			initiative_changed.emit(Dictionary(message).duplicate(true))
		"battle_ready": battle_ready.emit(Dictionary(message.get("match", {})).duplicate(true))
		"error": online_error.emit(String(message.get("message", "Online error")))


func _send(message: Dictionary) -> void:
	if socket.get_ready_state() != WebSocketPeer.STATE_OPEN:
		online_error.emit("Connect to the server first.")
		return
	socket.send_text(JSON.stringify(message))


func _schedule_reconnect_or_close(reason: String) -> void:
	if not intentional_disconnect and not resume_token.is_empty() and reconnect_attempt < RECONNECT_DELAYS.size():
		reconnect_at = Time.get_ticks_msec() + RECONNECT_DELAYS[reconnect_attempt]
		reconnect_attempt += 1
		_set_state(&"reconnecting")
		set_process(true)
		return
	_clear_session(); set_process(false); _set_state(&"disconnected")
	if not reason.is_empty(): online_error.emit(reason)


func _set_state(next: StringName) -> void:
	if state == next: return
	state = next
	connection_changed.emit(state)


func _clear_session() -> void:
	room.clear(); player_id = ""; reconnect_token = ""; resume_token = ""; reconnect_attempt = 0; received_sequences.clear()
	room_changed.emit(room)
