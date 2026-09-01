extends Control

const POKEMON_DIR := "res://database/pokemon"
const MOVE_DIR := "res://database/move_cards"
const LANG_DIR := "res://language/content"
const ENERGY_ICON_DIR := "res://assets/ui/energy"
const KYOKORO_ICON_DIR := "res://assets/ui/kyokoro"
const MOVE_CARD_BACKGROUND := "res://assets/move_cards/background.png"
const MAX_MOVES := 4

# Bundled fonts: do not rely on browser/OS font fallback. Keeping explicit
# preload references also guarantees that the Web exporter includes them.
const FONT_JA: Font = preload("res://assets/fonts/NotoSansJP/NotoSansJP-Regular.ttf")
const FONT_ZH_TW: Font = preload("res://assets/fonts/NotoSansTC/NotoSansTC-Regular.ttf")
const FONT_NINJA_ATTACK: Font = preload("res://assets/fonts/Ninjaattack/NinjaAttackItalic-p7x1O.ttf")

const LOCALES := {
	"English": "en_US",
	"Español": "es_ES",
	"日本語": "ja_JP",
	"繁體中文": "zh_TW"
}

const UI_TEXT := {
	"en_US": {
		"all_attack_types":"All types", "sort_original":"Original order", "sort_energy_asc":"Energy: low to high", "sort_energy_desc":"Energy: high to low", "sort_damage_desc":"Damage: high to low", "sort_damage_asc":"Damage: low to high", "selected_first":"Selected first", "reset_filters":"Reset",
		"title": "PLAKORO — Digital Move Cards", "setup_subtitle": "Choose one Pokémon and exactly four move cards for your physical tabletop game.", "pokemon": "Pokémon", "move_cards": "Move cards", "start_session": "Start Tabletop Session", "selected_count": "{current} / {max} selected", "used_cards": "Used cards: {cards}", "hide_info": "Hide info ▲", "show_info": "Show info ▼", "info_tooltip": "Hide or show the optional Pokémon / HP / weakness information.", "your_turn_short": "Turn {turn}  •  YOUR TURN", "opponent_turn_short": "Turn {turn}  •  OPPONENT TURN", "end_game": "End Game", "reduce_hp": "Reduce HP by 10", "restore_hp": "Restore HP by 10", "weakness": "Weakness:", "weakness_tooltip": "{type} weakness", "your_turn": "Turn {turn} — YOUR TURN: choose one move", "opponent_turn": "Turn {turn} — OPPONENT TURN: resolve the physical turn, then confirm when finished", "last_charakoro": "Last Charakoro: {result}", "roll_failed_ignored": "Enekoro insufficient — move failed; Charakoro effect ignored", "triggered": "Triggered: {effects}", "active_effect": "⚠ Active turn effect", "waiting_opponent": "WAITING FOR OPPONENT", "locked_last_turn": "LOCKED — used last turn", "locked_tooltip": "This move was used last turn and cannot be used this turn.", "opponent_finished": "Opponent Turn Finished", "roll_hint": "Roll Enekoro and Charakoro together on the physical table. The Enekoro requirement is validated first; only a successful move may trigger its Charakoro effect.", "cancel": "Cancel", "use_move": "Use Move", "resolve_roll": "Resolve Enekoro + Charakoro", "resolve_subtitle": "Enekoro is checked first. If it succeeds, select the Charakoro face from the same roll.", "enerkoro_failed": "Enekoro insufficient — move failed", "energy_succeeded": "Enekoro sufficient — continue", "select_face": "Enekoro succeeded — select Charakoro face", "card_stays_visible": "Check the move card while selecting the rolled face.", "back_to_energy": "Back to Enekoro check", "no_energy": "No Energy", "damage": "Damage {value}", "head_up": "Head Up", "head_down": "Head Down", "head_left": "Head Left", "head_right": "Head Right", "face_up": "Face Up", "face_down": "Face Down", "resolution_title": "Move Result", "result_total_damage": "Total damage", "result_effects": "Triggered effects", "result_active_effects": "Active turn effects", "result_no_effect": "No additional Charakoro effect", "result_failed": "Move failed — no damage or effects", "result_weakness_damage": "If Weakness applies: {value} total damage (+20)", "result_self_damage": "Apply to your Pokémon: {value} self-damage", "result_heal": "Apply to your Pokémon: heal {value} HP", "result_reduction": "Next opponent turn: reduce incoming attack damage by {value}", "result_immunity": "Next opponent turn: this Pokémon takes no attack damage", "close": "Close"
	},
	"es_ES": {
		"all_attack_types":"Todos los tipos", "sort_original":"Orden original", "sort_energy_asc":"Energía: menor a mayor", "sort_energy_desc":"Energía: mayor a menor", "sort_damage_desc":"Daño: mayor a menor", "sort_damage_asc":"Daño: menor a mayor", "selected_first":"Seleccionadas primero", "reset_filters":"Restablecer",
		"title": "PLAKORO — Cartas digitales de movimientos", "setup_subtitle": "Elige un Pokémon y exactamente cuatro cartas de movimiento para tu partida física.", "pokemon": "Pokémon", "move_cards": "Cartas de movimiento", "start_session": "Iniciar sesión de mesa", "selected_count": "{current} / {max} seleccionadas", "used_cards": "Cartas usadas: {cards}", "hide_info": "Ocultar información ▲", "show_info": "Mostrar información ▼", "info_tooltip": "Oculta o muestra la información opcional de Pokémon, PS y debilidad.", "your_turn_short": "Turno {turn}  •  TU TURNO", "opponent_turn_short": "Turno {turn}  •  TURNO DEL OPONENTE", "end_game": "Finalizar partida", "reduce_hp": "Reducir PS en 10", "restore_hp": "Recuperar 10 PS", "weakness": "Debilidad:", "weakness_tooltip": "Debilidad a {type}", "your_turn": "Turno {turn} — TU TURNO: elige un movimiento", "opponent_turn": "Turno {turn} — TURNO DEL OPONENTE: resuelve el turno físico y confirma al terminar", "last_charakoro": "Último Charakoro: {result}", "roll_failed_ignored": "Enekoro insuficiente — el movimiento falló; se ignora el efecto Charakoro", "triggered": "Activado: {effects}", "active_effect": "⚠ Efecto de turno activo", "waiting_opponent": "ESPERANDO AL OPONENTE", "locked_last_turn": "BLOQUEADO — usado el turno anterior", "locked_tooltip": "Este movimiento se usó el turno anterior y no puede usarse este turno.", "opponent_finished": "Turno del oponente terminado", "roll_hint": "Lanza Enekoro y Charakoro juntos en la mesa. Primero se valida el requisito de Enekoro; solo un movimiento exitoso puede activar su efecto Charakoro.", "cancel": "Cancelar", "use_move": "Usar movimiento", "resolve_roll": "Resolver Enekoro + Charakoro", "resolve_subtitle": "Primero se comprueba Enekoro. Si tiene éxito, elige la cara de Charakoro de la misma tirada.", "enerkoro_failed": "Enekoro insuficiente — movimiento fallido", "energy_succeeded": "Enekoro suficiente — continuar", "select_face": "Enekoro exitoso — elige la cara de Charakoro", "card_stays_visible": "Consulta la carta mientras eliges la cara obtenida.", "back_to_energy": "Volver a comprobar Enekoro", "no_energy": "Sin energía", "damage": "Daño {value}", "head_up": "Cabeza arriba", "head_down": "Cabeza abajo", "head_left": "Cabeza a la izquierda", "head_right": "Cabeza a la derecha", "face_up": "Cara arriba", "face_down": "Cara abajo", "resolution_title": "Resultado del movimiento", "result_total_damage": "Daño total", "result_effects": "Efectos activados", "result_active_effects": "Efectos de turno activos", "result_no_effect": "Sin efecto Charakoro adicional", "result_failed": "El movimiento falló: sin daño ni efectos", "result_weakness_damage": "Si se aplica Debilidad: {value} de daño total (+20)", "result_self_damage": "Aplica a tu Pokémon: {value} de daño propio", "result_heal": "Aplica a tu Pokémon: recupera {value} PS", "result_reduction": "Próximo turno rival: reduce el daño de ataque recibido en {value}", "result_immunity": "Próximo turno rival: este Pokémon no recibe daño de ataques", "close": "Cerrar"
	},
	"ja_JP": {
		"all_attack_types":"すべてのタイプ", "sort_original":"元の順番", "sort_energy_asc":"エネルギー：少ない順", "sort_energy_desc":"エネルギー：多い順", "sort_damage_desc":"ダメージ：高い順", "sort_damage_asc":"ダメージ：低い順", "selected_first":"選択済みを先頭", "reset_filters":"リセット",
		"title": "PLAKORO — デジタルわざカード", "setup_subtitle": "ポケモンを1匹選び、実際の卓上ゲームで使うわざカードを4枚選んでください。", "pokemon": "ポケモン", "move_cards": "わざカード", "start_session": "テーブルセッションを開始", "selected_count": "{current} / {max} 枚選択済み", "used_cards": "使用したカード：{cards}", "hide_info": "情報を隠す ▲", "show_info": "情報を表示 ▼", "info_tooltip": "ポケモン・HP・弱点の補助情報を表示または非表示にします。", "your_turn_short": "ターン {turn}  •  あなたのターン", "opponent_turn_short": "ターン {turn}  •  相手のターン", "end_game": "ゲーム終了", "reduce_hp": "HPを10減らす", "restore_hp": "HPを10回復", "weakness": "弱点：", "weakness_tooltip": "{type}弱点", "your_turn": "ターン {turn} — あなたのターン：わざを1つ選択", "opponent_turn": "ターン {turn} — 相手のターン：実物の盤面で処理し、完了後に確認してください", "last_charakoro": "直前のチャラコロ：{result}", "roll_failed_ignored": "エネコロ不足 — わざ失敗；チャラコロ効果は無効", "triggered": "発動：{effects}", "active_effect": "⚠ 発動中のターン効果", "waiting_opponent": "相手のターンを待っています", "locked_last_turn": "使用不可 — 前のターンに使用済み", "locked_tooltip": "このわざは前のターンに使用したため、今のターンは使用できません。", "opponent_finished": "相手のターン完了", "roll_hint": "実物の盤面でエネコロとチャラコロを同時に振ります。最初にエネコロ条件を確認し、わざが成功した場合のみチャラコロ効果を発動できます。", "cancel": "キャンセル", "use_move": "わざを使う", "resolve_roll": "エネコロ＋チャラコロ判定", "resolve_subtitle": "最初にエネコロを確認します。成功したら、同じ出目のチャラコロ面を選択してください。", "enerkoro_failed": "エネコロ不足 — わざ失敗", "energy_succeeded": "エネコロ成功 — 続ける", "select_face": "エネコロ成功 — チャラコロ面を選択", "card_stays_visible": "わざカードを確認しながら出た面を選んでください。", "back_to_energy": "エネコロ確認に戻る", "no_energy": "エネルギーなし", "damage": "ダメージ {value}", "head_up": "頭が上", "head_down": "頭が下", "head_left": "頭が左", "head_right": "頭が右", "face_up": "顔が上", "face_down": "顔が下", "resolution_title": "わざの結果", "result_total_damage": "合計ダメージ", "result_effects": "発動した効果", "result_active_effects": "発動中のターン効果", "result_no_effect": "追加のCharakoro効果なし", "result_failed": "わざ失敗：ダメージ・効果なし", "result_weakness_damage": "弱点なら合計{value}ダメージ（+20）", "result_self_damage": "自分のポケモンに適用：反動ダメージ {value}", "result_heal": "自分のポケモンに適用：HPを{value}回復", "result_reduction": "相手の次のターン：受ける攻撃ダメージを{value}減らす", "result_immunity": "相手の次のターン：このポケモンは攻撃ダメージを受けない", "close": "閉じる"
	},
	"zh_TW": {
		"all_attack_types":"全部屬性", "sort_original":"原始順序", "sort_energy_asc":"能量：低到高", "sort_energy_desc":"能量：高到低", "sort_damage_desc":"傷害：高到低", "sort_damage_asc":"傷害：低到高", "selected_first":"已選置頂", "reset_filters":"重設",
		"title": "PLAKORO — 數位招式卡", "setup_subtitle": "選擇一隻 Pokémon 與四張招式卡，在實體桌遊中使用。", "pokemon": "Pokémon", "move_cards": "招式卡", "start_session": "開始桌遊輔助", "selected_count": "已選 {current} / {max} 張", "used_cards": "已使用的卡片：{cards}", "hide_info": "隱藏資訊 ▲", "show_info": "顯示資訊 ▼", "info_tooltip": "顯示或隱藏 Pokémon、HP 與弱點等輔助資訊。", "your_turn_short": "第 {turn} 回合  •  你的回合", "opponent_turn_short": "第 {turn} 回合  •  對手回合", "end_game": "結束遊戲", "reduce_hp": "HP 減少 10", "restore_hp": "HP 回復 10", "weakness": "弱點：", "weakness_tooltip": "弱點：{type}", "your_turn": "第 {turn} 回合 — 你的回合：選擇一個招式", "opponent_turn": "第 {turn} 回合 — 對手回合：在實體桌面完成操作後確認結束", "last_charakoro": "上次 Charakoro：{result}", "roll_failed_ignored": "Enekoro 不足 — 招式失敗；忽略 Charakoro 效果", "triggered": "已觸發：{effects}", "active_effect": "⚠ 生效中的回合效果", "waiting_opponent": "等待對手回合", "locked_last_turn": "無法使用 — 上回合已使用", "locked_tooltip": "此招式上回合已使用，本回合無法再次使用。", "opponent_finished": "對手回合結束", "roll_hint": "請在實體桌面同時擲出 Enekoro 與 Charakoro。先確認 Enekoro 是否符合需求；招式成功後才能觸發 Charakoro 效果。", "cancel": "取消", "use_move": "使用招式", "resolve_roll": "判定 Enekoro + Charakoro", "resolve_subtitle": "先確認 Enekoro；若成功，請選擇同一次擲骰的 Charakoro 骰面。", "enerkoro_failed": "Enekoro 不足 — 招式失敗", "energy_succeeded": "Enekoro 足夠 — 繼續", "select_face": "Enekoro 成功 — 選擇 Charakoro 骰面", "card_stays_visible": "請對照招式卡並選擇擲出的骰面。", "back_to_energy": "返回 Enekoro 判定", "no_energy": "不需能量", "damage": "傷害 {value}", "head_up": "頭部朝上", "head_down": "頭部朝下", "head_left": "頭部朝左", "head_right": "頭部朝右", "face_up": "正面朝上", "face_down": "反面朝上", "resolution_title": "招式結果", "result_total_damage": "總傷害", "result_effects": "觸發效果", "result_active_effects": "生效中的回合效果", "result_no_effect": "沒有額外 Charakoro 效果", "result_failed": "招式失敗：沒有傷害或效果", "result_weakness_damage": "若命中弱點：總傷害 {value}（+20）", "result_self_damage": "套用到自己的 Pokémon：自傷 {value}", "result_heal": "套用到自己的 Pokémon：回復 HP {value}", "result_reduction": "對手下一回合：受到的攻擊傷害減少 {value}", "result_immunity": "對手下一回合：這隻 Pokémon 不會受到攻擊傷害", "close": "關閉"
	}
}

const ONLINE_UI_TEXT := {
	"en_US":{"online":"Connect","online_title":"Phone Connection","online_name":"Your name","online_server":"Server","online_connect":"Connect","online_disconnect":"Disconnect","online_create":"Create Room","online_join":"Join Room","online_code":"Room code","online_waiting":"Waiting for opponent","online_ready":"Connected • {code}","online_opponent_move":"Opponent's Move","online_hint":"Create a room on one phone, then enter its six-character code on the other phone.","online_invalid_code":"Enter a six-character room code.","initiative_title":"Decide who goes first","initiative_needed":"Choose coin flip or rock-paper-scissors before starting.","coin_flip":"Flip Coin","rps":"Rock Paper Scissors","rock":"Rock","paper":"Paper","scissors":"Scissors","initiative_waiting":"Waiting for the opponent's choice…","initiative_tie":"Tie — choose again","initiative_you_first":"You go first","initiative_opponent_first":"Opponent goes first","ready_for_battle":"Ready","waiting_ready":"Waiting for opponent to finish selecting…","online_reconnecting":"Reconnecting…","opponent_disconnected":"Opponent offline"},
	"es_ES":{"online":"Conectar","online_title":"Conexión entre teléfonos","online_name":"Tu nombre","online_server":"Servidor","online_connect":"Conectar","online_disconnect":"Desconectar","online_create":"Crear sala","online_join":"Unirse","online_code":"Código de sala","online_waiting":"Esperando al oponente","online_ready":"Conectado • {code}","online_opponent_move":"Movimiento del oponente","online_hint":"Crea una sala en un teléfono e introduce el código de seis caracteres en el otro.","online_invalid_code":"Introduce un código de seis caracteres.","initiative_title":"Decidir quién empieza","initiative_needed":"Elige moneda o piedra, papel o tijera antes de empezar.","coin_flip":"Lanzar moneda","rps":"Piedra, papel o tijera","rock":"Piedra","paper":"Papel","scissors":"Tijera","initiative_waiting":"Esperando la elección del oponente…","initiative_tie":"Empate: elige de nuevo","initiative_you_first":"Tú empiezas","initiative_opponent_first":"El oponente empieza","ready_for_battle":"Listo","waiting_ready":"Esperando a que el oponente termine de elegir…","online_reconnecting":"Reconectando…","opponent_disconnected":"Rival sin conexión"},
	"ja_JP":{"online":"接続","online_title":"スマホ接続","online_name":"あなたの名前","online_server":"サーバー","online_connect":"接続","online_disconnect":"切断","online_create":"ルーム作成","online_join":"参加","online_code":"ルームコード","online_waiting":"相手を待っています","online_ready":"接続済み • {code}","online_opponent_move":"相手のわざ","online_hint":"1台目でルームを作成し、2台目に6文字のコードを入力します。","online_invalid_code":"6文字のルームコードを入力してください。","initiative_title":"先攻を決める","initiative_needed":"コイントスかじゃんで先攻を決めてください。","coin_flip":"コイントス","rps":"じゃんけん","rock":"グー","paper":"パー","scissors":"チョキ","initiative_waiting":"相手の選択を待っています…","initiative_tie":"あいこ — もう一度選択","initiative_you_first":"あなたが先攻","initiative_opponent_first":"相手が先攻","ready_for_battle":"準備完了","waiting_ready":"相手の選択完了を待っています…","online_reconnecting":"再接続中…","opponent_disconnected":"相手オフライン"},
	"zh_TW":{"online":"連線","online_title":"手機對戰連線","online_name":"你的名稱","online_server":"伺服器","online_connect":"連線","online_disconnect":"斷開連線","online_create":"建立房間","online_join":"加入房間","online_code":"房間碼","online_waiting":"等待對手加入","online_ready":"已連線 • {code}","online_opponent_move":"對手出招","online_hint":"在一台手機建立房間，再於另一台輸入六位房間碼。","online_invalid_code":"請輸入六位房間碼。","initiative_title":"決定先攻","initiative_needed":"開始前請以擲硬幣或猜拳決定先攻。","coin_flip":"擲硬幣","rps":"猜拳","rock":"石頭","paper":"布","scissors":"剪刀","initiative_waiting":"等待對手選擇…","initiative_tie":"平手，請重新選擇","initiative_you_first":"你先攻","initiative_opponent_first":"對手先攻","ready_for_battle":"準備完成","waiting_ready":"等待對手完成選擇…","online_reconnecting":"重新連線中…","opponent_disconnected":"對手離線"}
}

const TYPE_COLORS := {
	"fire": Color("7f3027"), "water": Color("255678"), "electric": Color("8b7620"),
	"grass": Color("376c3d"), "flying": Color("546c86"), "normal": Color("62656c"),
	"psychic": Color("783b6c"), "fighting": Color("7d4932"), "steel": Color("52676c"),
	"dark": Color("3f3a49")
}

const ONLINE_ENERGY_CODES := {
	"A":"grass", "B":"fire", "C":"water", "D":"electric", "E":"psychic",
	"F":"fighting", "G":"dark", "H":"steel", "I":"flying"
}

var pokemon_docs: Array[Dictionary] = []
var move_docs: Dictionary = {}
var locale_entries: Dictionary = {}
var fallback_entries: Dictionary = {}
var current_locale := "en_US"
var selected_pokemon: Dictionary = {}
var selected_move_ids: Array[String] = []
var move_checkboxes: Dictionary = {}

# Tabletop session state
var current_hp: int = 0
var previous_move_id := ""
var turn_number := 1
var phase := "player" # player | opponent
var pending_opponent_reminders: Array[Dictionary] = []
var pending_self_reminders: Array[Dictionary] = []
var last_kyokoro_result := ""
var last_resolved_effects: Array[String] = []
var last_resolution_details: Dictionary = {}

var root_margin: MarginContainer
var page: VBoxContainer
var title_label: Label
var language_option: OptionButton
var pokemon_option: OptionButton
var pokemon_preview: TextureRect
var pokemon_name_label: Label
var pokemon_meta_label: Label
var pokemon_meta_row: HBoxContainer
var pokemon_type_icon: TextureRect
var pokemon_weakness_row: HBoxContainer
var selection_count_label: Label
var moves_grid: GridContainer
var start_button: Button
var move_type_filter: OptionButton
var move_sort_option: OptionButton
var selected_first_toggle: CheckButton
var current_move_type_filter := ""
var current_move_sort := "original"
var selected_moves_first := true
var hp_label: Label
var phase_label: Label
var reminder_box: VBoxContainer
var play_moves_grid: GridContainer
var app_theme: Theme
var status_details_expanded := false
var showing_play_page := false
var last_layout_signature := ""
var layout_refresh_pending := false
var online_sequence := 0
var online_waiting_to_start := false
var online_status_buttons: Array[Button] = []

func _ready() -> void:
	_load_database()
	_load_locale("en_US")
	_build_shell()
	_show_setup_page()
	get_viewport().size_changed.connect(_on_viewport_size_changed)
	OnlineRelay.opponent_move_received.connect(_on_opponent_move_received)
	OnlineRelay.online_error.connect(_on_online_error)
	OnlineRelay.room_changed.connect(_on_online_room_changed)
	OnlineRelay.initiative_changed.connect(_on_online_initiative_changed)
	OnlineRelay.battle_ready.connect(_on_online_battle_ready)
	OnlineRelay.connection_changed.connect(_on_online_connection_changed)

func _load_database() -> void:
	pokemon_docs.clear()
	move_docs.clear()
	var pdir := DirAccess.open(POKEMON_DIR)
	if pdir:
		var files := pdir.get_files()
		files.sort()
		for file_name in files:
			if file_name.ends_with(".json"):
				var doc := _read_json(POKEMON_DIR.path_join(file_name))
				if not doc.is_empty(): pokemon_docs.append(doc)
	# Tabletop companion shows one entry per species. A/B physical variants are
	# merged because they represent the same playable Pokémon and move pool.
	var grouped: Dictionary = {}
	for doc in pokemon_docs:
		var species_id := String(doc.get("species_id", doc.get("id", "")))
		if not grouped.has(species_id):
			grouped[species_id] = doc.duplicate(true)
		else:
			var merged: Dictionary = grouped[species_id]
			var existing_moves: Array = merged.get("available_move_card_ids", []) as Array
			for raw_move in doc.get("available_move_card_ids", []) as Array:
				if raw_move not in existing_moves: existing_moves.append(raw_move)
			merged["available_move_card_ids"] = existing_moves
			# Prefer the A/standard image as the single representative image.
			var current_id := String(merged.get("id", ""))
			var candidate_id := String(doc.get("id", ""))
			if ("_b1" in current_id and "_a1" in candidate_id) or ("standard" in candidate_id and "standard" not in current_id):
				merged["id"] = candidate_id
			grouped[species_id] = merged
	pokemon_docs.clear()
	for species_id in grouped.keys(): pokemon_docs.append(grouped[species_id])
	pokemon_docs.sort_custom(func(a: Dictionary, b: Dictionary): return String(a.get("display_name", "")) < String(b.get("display_name", "")))
	var mdir := DirAccess.open(MOVE_DIR)
	if mdir:
		var files := mdir.get_files()
		files.sort()
		for file_name in files:
			if file_name.ends_with(".json"):
				var doc := _read_json(MOVE_DIR.path_join(file_name))
				if not doc.is_empty(): move_docs[String(doc.get("id", ""))] = doc

func _read_json(path: String) -> Dictionary:
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null: return {}
	var parsed = JSON.parse_string(file.get_as_text())
	file.close()
	return parsed as Dictionary if parsed is Dictionary else {}

func _load_locale(locale: String) -> void:
	current_locale = locale
	locale_entries = _merge_locale(locale)
	fallback_entries = {} if locale == "en_US" else _merge_locale("en_US")
	_apply_locale_font()

func _apply_locale_font() -> void:
	# Japanese and Traditional Chinese intentionally use locale-specific Noto
	# Sans builds. This avoids CJK glyph substitution and missing-glyph squares
	# in Web exports, while still covering Latin text in the same UI.
	var selected_font: Font = FONT_JA
	if current_locale == "zh_TW":
		selected_font = FONT_ZH_TW
	elif current_locale == "ja_JP":
		selected_font = FONT_JA
	else:
		# Noto Sans JP contains the Latin glyphs needed by English/Spanish.
		# Using a bundled font for every locale keeps Web/Windows/Linux rendering
		# deterministic instead of falling back to an OS/browser font.
		selected_font = FONT_JA

	if app_theme == null:
		app_theme = Theme.new()
	app_theme.default_font = selected_font
	app_theme.default_font_size = 16

	# High-contrast controls for dark Web/desktop UI. The move cards remain the
	# visual focus while utility controls are clearly separated from the canvas.
	for type_name in ["Button", "OptionButton"]:
		app_theme.set_color("font_color", type_name, Color("edf4fb"))
		app_theme.set_color("font_hover_color", type_name, Color.WHITE)
		app_theme.set_stylebox("normal", type_name, _ui_button_style(Color("18212d"), Color("34465a"), 1))
		app_theme.set_stylebox("hover", type_name, _ui_button_style(Color("243246"), Color("5f83a8"), 2))
		app_theme.set_stylebox("pressed", type_name, _ui_button_style(Color("101a26"), Color("77a6d5"), 2))
		app_theme.set_stylebox("disabled", type_name, _ui_button_style(Color("11161d"), Color("252e39"), 1))
	theme = app_theme

func _merge_locale(locale: String) -> Dictionary:
	var merged := {}
	var dir := DirAccess.open(LANG_DIR)
	if dir == null: return merged
	var files := dir.get_files(); files.sort()
	for file_name in files:
		if not file_name.ends_with(".json") or file_name.begins_with("_"): continue
		var doc := _read_json(LANG_DIR.path_join(file_name))
		if String(doc.get("locale", "")) != locale: continue
		var entries = doc.get("entries", {})
		if entries is Dictionary:
			for key in entries.keys(): merged[String(key)] = entries[key]
	return merged

func _tr_content(key: String, fallback := "") -> String:
	if locale_entries.has(key): return String(locale_entries[key]).replace("\\n", "\n")
	if fallback_entries.has(key): return String(fallback_entries[key]).replace("\\n", "\n")
	return fallback

func _tr_ui(key: String, replacements: Dictionary = {}) -> String:
	var locale_table: Dictionary = UI_TEXT.get(current_locale, UI_TEXT["en_US"])
	var online_table: Dictionary = ONLINE_UI_TEXT.get(current_locale, ONLINE_UI_TEXT["en_US"])
	var value := String(locale_table.get(key, online_table.get(key, (UI_TEXT["en_US"] as Dictionary).get(key, (ONLINE_UI_TEXT["en_US"] as Dictionary).get(key, key)))))
	for replacement_key in replacements.keys():
		value = value.replace("{%s}" % String(replacement_key), str(replacements[replacement_key]))
	return value

func _pokemon_name(doc: Dictionary) -> String:
	return _tr_content("pokemon.%s.name" % String(doc.get("species_id", "")), String(doc.get("display_name", "")))

func _move_name(doc: Dictionary) -> String:
	return _tr_content("move.%s.name" % String(doc.get("move_name_id", "")), String(doc.get("display_name", "")))

func _move_description(doc: Dictionary) -> String:
	var card_id := String(doc.get("id", ""))
	var move_name_id := String(doc.get("move_name_id", ""))
	var card_key := "move_card.%s.description" % card_id
	var move_key := "move.%s.description" % move_name_id
	# Prefer any translation in the selected locale before consulting English.
	# Otherwise an English card-specific entry can hide an available localized
	# generic move description.
	if locale_entries.has(card_key):
		return _localize_orientation_tokens(String(locale_entries[card_key]).replace("\\n", "\n"))
	if locale_entries.has(move_key):
		return _localize_orientation_tokens(String(locale_entries[move_key]).replace("\\n", "\n"))
	if fallback_entries.has(card_key):
		return _localize_orientation_tokens(String(fallback_entries[card_key]).replace("\\n", "\n"))
	if fallback_entries.has(move_key):
		return _localize_orientation_tokens(String(fallback_entries[move_key]).replace("\\n", "\n"))
	var source: Dictionary = doc.get("source", {}) as Dictionary
	return _localize_orientation_tokens(String(source.get("raw_text", "")))

func _move_effect_text(move_id: String, move_doc: Dictionary) -> String:
	var source: Dictionary = move_doc.get("source", {}) as Dictionary
	var source_move_effects: Array = source.get("move_effect_text", []) as Array
	if source_move_effects.is_empty():
		return ""
	var card_key := "move_card.%s.move_effect" % move_id
	var move_key := "move.%s.move_effect" % String(move_doc.get("move_name_id", ""))
	if locale_entries.has(card_key):
		return _without_move_effect_heading(String(locale_entries[card_key]).replace("\\n", "\n"))
	if locale_entries.has(move_key):
		return _without_move_effect_heading(String(locale_entries[move_key]).replace("\\n", "\n"))
	if fallback_entries.has(card_key):
		return _without_move_effect_heading(String(fallback_entries[card_key]).replace("\\n", "\n"))
	if fallback_entries.has(move_key):
		return _without_move_effect_heading(String(fallback_entries[move_key]).replace("\\n", "\n"))
	var description := _move_description(move_doc)
	var outcome_texts: Array[String] = []
	var outcomes := _move_outcome_rules(move_doc)
	for i in outcomes.size():
		outcome_texts.append(_localized_outcome_text(move_id, move_doc, i, outcomes[i] as Dictionary).strip_edges())
	var move_lines: Array[String] = []
	for raw_line in description.split("\n", false):
		var line := String(raw_line).strip_edges()
		if line.is_empty():
			continue
		var is_outcome_line := false
		for outcome_text in outcome_texts:
			if not outcome_text.is_empty() and line.contains(outcome_text):
				is_outcome_line = true
				break
		if not is_outcome_line:
			move_lines.append(line)
	if not move_lines.is_empty():
		return _without_move_effect_heading("\n".join(move_lines))
	return "\n".join(source_move_effects)

func _without_move_effect_heading(text: String) -> String:
	var cleaned := text.strip_edges()
	for heading in ["Move Effect:", "Move effect:", "Efecto del movimiento:", "招式效果：", "招式效果:", "わざ効果：", "わざ効果:"]:
		if cleaned.begins_with(heading):
			return cleaned.trim_prefix(heading).strip_edges()
	return cleaned


func _move_outcome_rules(move_doc: Dictionary) -> Array[Dictionary]:
	var result: Array[Dictionary] = []
	for raw in move_doc.get("outcome_rules", []) as Array:
		result.append(raw as Dictionary)
	if not result.is_empty():
		return result
	# A small group of advanced cards stores confirmed Charakoro mappings in
	# special_effects because their runtime action is not a basic opcode. They
	# still need the same face display and roll-selection flow as normal cards.
	for raw in move_doc.get("special_effects", []) as Array:
		var special := raw as Dictionary
		var orientations: Array = special.get("confirmed_orientations", []) as Array
		if orientations.is_empty():
			continue
		result.append({
			"condition": {
				"type": "kyokoro_orientation_any",
				"orientations": orientations.duplicate()
			},
			"actions": [],
			"raw_text": String(special.get("text", special.get("source_text", "")))
		})
	return result

func _build_shell() -> void:
	_apply_locale_font()
	root_margin = MarginContainer.new()
	root_margin.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	root_margin.add_theme_constant_override("margin_left", 18)
	root_margin.add_theme_constant_override("margin_right", 18)
	root_margin.add_theme_constant_override("margin_top", 14)
	root_margin.add_theme_constant_override("margin_bottom", 14)
	add_child(root_margin)
	var viewport_scroll := ScrollContainer.new()
	viewport_scroll.name = "MainViewportScroll"
	viewport_scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	viewport_scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	viewport_scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	_configure_touch_scrollbar(viewport_scroll)
	root_margin.add_child(viewport_scroll)
	var page_padding := MarginContainer.new()
	page_padding.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	page_padding.size_flags_vertical = Control.SIZE_EXPAND_FILL
	page_padding.add_theme_constant_override("margin_right",40)
	viewport_scroll.add_child(page_padding)
	page = VBoxContainer.new()
	page.name = "Page"
	page.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	page.size_flags_vertical = Control.SIZE_EXPAND_FILL
	page.custom_minimum_size.y = maxf(0.0, get_viewport_rect().size.y - 28.0)
	page.add_theme_constant_override("separation", 14)
	page_padding.add_child(page)

func _clear_page() -> void:
	online_status_buttons.clear()
	for child in page.get_children():
		page.remove_child(child)
		child.queue_free()
	# Dynamic UI references must not point at nodes queued for deletion when the
	# compact status panel is collapsed.
	hp_label = null
	phase_label = null
	reminder_box = null

func _header(subtitle: String) -> void:
	var row := HBoxContainer.new(); row.add_theme_constant_override("separation", 16); page.add_child(row)
	var titles := VBoxContainer.new(); titles.size_flags_horizontal = Control.SIZE_EXPAND_FILL; row.add_child(titles)
	title_label = Label.new(); title_label.text = _tr_ui("title"); title_label.add_theme_font_size_override("font_size", 30); titles.add_child(title_label)
	var sub := Label.new(); sub.text = subtitle; sub.modulate = Color(0.78,0.82,0.88); sub.add_theme_font_size_override("font_size", 15); titles.add_child(sub)
	language_option = OptionButton.new(); language_option.custom_minimum_size = Vector2(170,46)
	var idx := 0; var selected_idx := 0
	for label in LOCALES.keys():
		language_option.add_item(label); language_option.set_item_metadata(idx, LOCALES[label])
		if LOCALES[label] == current_locale: selected_idx = idx
		idx += 1
	language_option.select(selected_idx); language_option.item_selected.connect(_on_language_selected); row.add_child(language_option)
	var online_button := Button.new(); online_button.text = _online_button_text(); online_button.custom_minimum_size = Vector2(150,46); online_button.pressed.connect(_open_online_popup); row.add_child(online_button); online_status_buttons.append(online_button)
	page.add_child(HSeparator.new())

func _show_setup_page() -> void:
	showing_play_page = false
	last_layout_signature = _layout_signature()
	var preserved_move_ids := selected_move_ids.duplicate()
	_clear_page(); _header(_tr_ui("setup_subtitle"))
	var body := HBoxContainer.new(); body.size_flags_horizontal = Control.SIZE_EXPAND_FILL; body.size_flags_vertical = Control.SIZE_EXPAND_FILL; body.add_theme_constant_override("separation",24); page.add_child(body)
	var viewport_size := get_viewport_rect().size
	var left_width := clampf(viewport_size.x * 0.24, 270.0, 360.0)
	var preview_height := clampf(viewport_size.y * 0.34, 190.0, 280.0)
	var left := VBoxContainer.new(); left.custom_minimum_size = Vector2(left_width,0); left.size_flags_vertical = Control.SIZE_EXPAND_FILL; left.add_theme_constant_override("separation",12); body.add_child(left)
	var choose_label := Label.new(); choose_label.text = _tr_ui("pokemon"); choose_label.add_theme_font_size_override("font_size",20); left.add_child(choose_label)
	pokemon_option = OptionButton.new(); pokemon_option.custom_minimum_size = Vector2(300,48)
	for i in pokemon_docs.size():
		var doc := pokemon_docs[i]; pokemon_option.add_item(_pokemon_name(doc)); pokemon_option.set_item_metadata(i,String(doc.get("id","")))
	pokemon_option.item_selected.connect(_on_pokemon_selected); left.add_child(pokemon_option)
	pokemon_preview = TextureRect.new(); pokemon_preview.custom_minimum_size = Vector2(left_width,preview_height); pokemon_preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE; pokemon_preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED; left.add_child(pokemon_preview)
	pokemon_meta_row = HBoxContainer.new(); pokemon_meta_row.add_theme_constant_override("separation", 10); left.add_child(pokemon_meta_row)
	pokemon_name_label = Label.new(); pokemon_name_label.add_theme_font_size_override("font_size",24); pokemon_name_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER; pokemon_meta_row.add_child(pokemon_name_label)
	pokemon_type_icon = TextureRect.new(); pokemon_type_icon.custom_minimum_size = Vector2(30,30); pokemon_type_icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE; pokemon_type_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED; pokemon_type_icon.mouse_filter = Control.MOUSE_FILTER_IGNORE; pokemon_meta_row.add_child(pokemon_type_icon)
	pokemon_meta_label = Label.new()
	pokemon_meta_label.autowrap_mode = TextServer.AUTOWRAP_OFF
	pokemon_meta_label.custom_minimum_size = Vector2(105,30)
	pokemon_meta_label.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
	pokemon_meta_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	left.add_child(pokemon_meta_label)
	pokemon_weakness_row = HBoxContainer.new(); pokemon_weakness_row.add_theme_constant_override("separation",8); left.add_child(pokemon_weakness_row)
	var right := VBoxContainer.new(); right.size_flags_horizontal = Control.SIZE_EXPAND_FILL; right.size_flags_vertical = Control.SIZE_EXPAND_FILL; right.add_theme_constant_override("separation",10); body.add_child(right)
	var move_header := HBoxContainer.new(); right.add_child(move_header)
	var move_title := Label.new(); move_title.text = _tr_ui("move_cards"); move_title.add_theme_font_size_override("font_size",20); move_title.size_flags_horizontal = Control.SIZE_EXPAND_FILL; move_header.add_child(move_title)
	selection_count_label = Label.new(); move_header.add_child(selection_count_label)
	var filter_bar := HBoxContainer.new(); filter_bar.add_theme_constant_override("separation",8); right.add_child(filter_bar)
	move_type_filter = OptionButton.new(); move_type_filter.custom_minimum_size = Vector2(155,42); move_type_filter.item_selected.connect(_on_move_type_filter_selected); filter_bar.add_child(move_type_filter)
	move_sort_option = OptionButton.new(); move_sort_option.custom_minimum_size = Vector2(205,42); _populate_move_sort_options(); move_sort_option.item_selected.connect(_on_move_sort_selected); filter_bar.add_child(move_sort_option)
	selected_first_toggle = CheckButton.new(); selected_first_toggle.text = _tr_ui("selected_first"); selected_first_toggle.button_pressed = selected_moves_first; selected_first_toggle.toggled.connect(_on_selected_first_toggled); filter_bar.add_child(selected_first_toggle)
	var reset_filters := Button.new(); reset_filters.text = _tr_ui("reset_filters"); reset_filters.custom_minimum_size = Vector2(90,42); reset_filters.pressed.connect(_reset_move_filters); filter_bar.add_child(reset_filters)
	var scroll := ScrollContainer.new(); scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL; scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL; scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED; _configure_touch_scrollbar(scroll); right.add_child(scroll)
	var scroll_content_margin := MarginContainer.new(); scroll_content_margin.size_flags_horizontal = Control.SIZE_EXPAND_FILL; scroll_content_margin.add_theme_constant_override("margin_right",44); scroll.add_child(scroll_content_margin)
	moves_grid = GridContainer.new(); moves_grid.columns = _setup_move_columns(); moves_grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL; moves_grid.add_theme_constant_override("h_separation",12); moves_grid.add_theme_constant_override("v_separation",12); scroll_content_margin.add_child(moves_grid)
	start_button = Button.new(); start_button.text = _tr_ui("start_session"); start_button.custom_minimum_size = Vector2(0,64); start_button.add_theme_font_size_override("font_size",20); start_button.add_theme_color_override("font_color",Color.WHITE); start_button.add_theme_color_override("font_hover_color",Color.WHITE); start_button.add_theme_stylebox_override("normal",_ui_button_style(Color("167a67"),Color("56d6b9"),2)); start_button.add_theme_stylebox_override("hover",_ui_button_style(Color("1d9a7f"),Color("8cf4d9"),3)); start_button.add_theme_stylebox_override("pressed",_ui_button_style(Color("116052"),Color("b2ffec"),3)); start_button.add_theme_stylebox_override("disabled",_ui_button_style(Color("111a20"),Color("2b3a42"),1)); start_button.pressed.connect(_start_session); right.add_child(start_button)
	if pokemon_docs.size() > 0:
		var desired_id := String(selected_pokemon.get("id", "")); var select_index := 0
		for i in pokemon_docs.size():
			if String(pokemon_docs[i].get("id","")) == desired_id: select_index = i; break
		pokemon_option.select(select_index); _select_pokemon(pokemon_docs[select_index])
		for raw_move_id in preserved_move_ids:
			var move_id := String(raw_move_id)
			if move_checkboxes.has(move_id):
				(move_checkboxes[move_id] as BaseButton).set_pressed_no_signal(true)
				selected_move_ids.append(move_id)
		_update_selection_state()

func _on_language_selected(index: int) -> void:
	_load_locale(String(language_option.get_item_metadata(index)))
	if phase == "player" or phase == "opponent":
		if not selected_move_ids.is_empty() and current_hp > 0: _show_play_page()
		else: _show_setup_page()
	else: _show_setup_page()

func _on_pokemon_selected(index: int) -> void:
	if index >= 0 and index < pokemon_docs.size(): _select_pokemon(pokemon_docs[index])

func _select_pokemon(doc: Dictionary) -> void:
	_cancel_online_ready()
	selected_pokemon = doc; selected_move_ids.clear(); move_checkboxes.clear()
	pokemon_name_label.text = _pokemon_name(doc)
	pokemon_meta_label.text = "HP %d" % int(doc.get("max_hp", 0))
	var setup_type := String(doc.get("pokemon_type", ""))
	var setup_type_path := "%s/%s.webp" % [ENERGY_ICON_DIR, setup_type]
	pokemon_type_icon.texture = load(setup_type_path) if ResourceLoader.exists(setup_type_path) else null
	pokemon_type_icon.tooltip_text = _type_name(setup_type)
	var image_path := "res://assets/pokemon/images/%s.png" % String(doc.get("id","")); pokemon_preview.texture = load(image_path) if ResourceLoader.exists(image_path) else null
	_refresh_setup_weakness(doc)
	_refresh_move_type_filter()
	_rebuild_move_choices()

func _refresh_setup_weakness(doc: Dictionary) -> void:
	if pokemon_weakness_row == null: return
	for child in pokemon_weakness_row.get_children():
		pokemon_weakness_row.remove_child(child)
		child.queue_free()
	var title := Label.new()
	title.text = _tr_ui("weakness")
	title.add_theme_color_override("font_color", Color("aebfd0"))
	pokemon_weakness_row.add_child(title)
	var weaknesses: Array = doc.get("weaknesses", []) as Array
	if weaknesses.is_empty():
		var none := Label.new()
		none.text = "—"
		pokemon_weakness_row.add_child(none)
		return
	for raw in weaknesses:
		var weakness: Dictionary = raw as Dictionary
		var type_id := String(weakness.get("attack_type", ""))
		pokemon_weakness_row.add_child(_energy_icon(type_id, 30))
		var bonus := Label.new()
		bonus.text = "+%d" % int(weakness.get("bonus_damage", 0))
		bonus.tooltip_text = _tr_ui("weakness_tooltip", {"type":_type_name(type_id)})
		bonus.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		bonus.add_theme_color_override("font_color", Color("ffd47a"))
		pokemon_weakness_row.add_child(bonus)


func _populate_move_sort_options() -> void:
	move_sort_option.clear()
	for item in [
		["sort_original", "original"],
		["sort_energy_asc", "energy_asc"],
		["sort_energy_desc", "energy_desc"],
		["sort_damage_desc", "damage_desc"],
		["sort_damage_asc", "damage_asc"]
	]:
		move_sort_option.add_item(_tr_ui(String(item[0])))
		move_sort_option.set_item_metadata(move_sort_option.item_count - 1, String(item[1]))
	for i in move_sort_option.item_count:
		if String(move_sort_option.get_item_metadata(i)) == current_move_sort: move_sort_option.select(i); break


func _refresh_move_type_filter() -> void:
	if move_type_filter == null: return
	var available_types: Array[String] = []
	for raw_id in selected_pokemon.get("available_move_card_ids", []) as Array:
		var move_id := String(raw_id)
		if not move_docs.has(move_id): continue
		var type_id := String((move_docs[move_id] as Dictionary).get("attack_type", "normal"))
		if type_id not in available_types: available_types.append(type_id)
	available_types.sort_custom(func(a: String, b: String): return _type_name(a) < _type_name(b))
	if not current_move_type_filter.is_empty() and current_move_type_filter not in available_types: current_move_type_filter = ""
	move_type_filter.clear()
	move_type_filter.add_item(_tr_ui("all_attack_types")); move_type_filter.set_item_metadata(0, "")
	for type_id in available_types:
		move_type_filter.add_item(_type_name(type_id)); move_type_filter.set_item_metadata(move_type_filter.item_count - 1, type_id)
	for i in move_type_filter.item_count:
		if String(move_type_filter.get_item_metadata(i)) == current_move_type_filter: move_type_filter.select(i); break


func _on_move_type_filter_selected(index: int) -> void:
	current_move_type_filter = String(move_type_filter.get_item_metadata(index))
	_rebuild_move_choices()


func _on_move_sort_selected(index: int) -> void:
	current_move_sort = String(move_sort_option.get_item_metadata(index))
	_rebuild_move_choices()


func _on_selected_first_toggled(enabled: bool) -> void:
	selected_moves_first = enabled
	_rebuild_move_choices()


func _reset_move_filters() -> void:
	current_move_type_filter = ""
	current_move_sort = "original"
	selected_moves_first = true
	_refresh_move_type_filter()
	_populate_move_sort_options()
	selected_first_toggle.set_pressed_no_signal(true)
	_rebuild_move_choices()


func _move_energy_total(move_doc: Dictionary) -> int:
	var total := 0
	for raw in move_doc.get("energy_cost", []) as Array: total += int((raw as Dictionary).get("count", 0))
	return total


func _sort_move_ids(ids: Array, original_positions: Dictionary) -> void:
	ids.sort_custom(func(a_raw, b_raw):
		var a := String(a_raw); var b := String(b_raw)
		if selected_moves_first:
			var a_selected := a in selected_move_ids; var b_selected := b in selected_move_ids
			if a_selected != b_selected: return a_selected
		var a_doc: Dictionary = move_docs[a]; var b_doc: Dictionary = move_docs[b]
		match current_move_sort:
			"energy_asc", "energy_desc":
				var av := _move_energy_total(a_doc); var bv := _move_energy_total(b_doc)
				if av != bv: return av < bv if current_move_sort == "energy_asc" else av > bv
			"damage_asc", "damage_desc":
				var a_damage = a_doc.get("printed_damage", null); var b_damage = b_doc.get("printed_damage", null)
				if a_damage == null and b_damage != null: return false
				if a_damage != null and b_damage == null: return true
				if a_damage != null and b_damage != null and int(a_damage) != int(b_damage): return int(a_damage) < int(b_damage) if current_move_sort == "damage_asc" else int(a_damage) > int(b_damage)
		return int(original_positions.get(a, 0)) < int(original_positions.get(b, 0))
	)

func _rebuild_move_choices() -> void:
	for child in moves_grid.get_children(): moves_grid.remove_child(child); child.queue_free()
	move_checkboxes.clear()
	var viewport_width := get_viewport_rect().size.x
	var setup_left_width := clampf(viewport_width * 0.24, 270.0, 360.0)
	var setup_columns := _setup_move_columns()
	var available_cards_width := maxf(330.0, viewport_width - setup_left_width - 120.0)
	var estimated_card_width := (available_cards_width - float(maxi(0, setup_columns - 1)) * 12.0) / float(setup_columns)
	var setup_card_height := clampf(estimated_card_width * 178.0 / 300.0, 190.0, 260.0)
	var source_ids: Array = selected_pokemon.get("available_move_card_ids",[]) as Array
	var ids: Array = []
	var original_positions := {}
	for i in source_ids.size():
		var move_id := String(source_ids[i]); original_positions[move_id] = i
		if not move_docs.has(move_id): continue
		if not current_move_type_filter.is_empty() and String((move_docs[move_id] as Dictionary).get("attack_type", "normal")) != current_move_type_filter: continue
		ids.append(move_id)
	_sort_move_ids(ids, original_positions)
	for raw_id in ids:
		var move_id := String(raw_id)
		if not move_docs.has(move_id): continue
		var move_doc: Dictionary = move_docs[move_id]
		var check := Button.new()
		check.name = "MoveChoice_%s" % move_id
		check.text = ""
		check.toggle_mode = true
		check.custom_minimum_size = Vector2(0, setup_card_height)
		check.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		check.tooltip_text = ""
		check.add_theme_stylebox_override("normal", _transparent_card_button_style(Color("43576b"), 2))
		check.add_theme_stylebox_override("hover", _transparent_card_button_style(Color("8fc7ff"), 3))
		check.add_theme_stylebox_override("pressed", _transparent_card_button_style(Color("56d6b9"), 5))
		check.add_theme_stylebox_override("focus", _transparent_card_button_style(Color("a8f5e5"), 4))
		check.toggled.connect(_on_move_toggled.bind(move_id))
		moves_grid.add_child(check)
		var formal_card := _build_real_move_card(move_id, move_doc, false, true)
		formal_card.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		formal_card.offset_left = 7.0
		formal_card.offset_top = 7.0
		formal_card.offset_right = -7.0
		formal_card.offset_bottom = -7.0
		check.add_child(formal_card)
		move_checkboxes[move_id] = check
		check.set_pressed_no_signal(move_id in selected_move_ids)
	_update_selection_state()

func _add_setup_effect_summary(card: VBoxContainer, move_id: String, move_doc: Dictionary) -> void:
	var outcomes := _move_outcome_rules(move_doc)
	var move_effect := _move_effect_text(move_id, move_doc)
	if not move_effect.is_empty():
		var move_effect_label := Label.new()
		move_effect_label.text = _first_line(move_effect, 125)
		move_effect_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		move_effect_label.max_lines_visible = 2
		move_effect_label.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
		card.add_child(move_effect_label)
	if outcomes.is_empty():
		if move_effect.is_empty():
			var desc := Label.new()
			desc.text = _first_line(_move_description(move_doc), 125)
			desc.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
			desc.max_lines_visible = 2
			desc.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
			card.add_child(desc)
		return
	for i in mini(outcomes.size(), 2):
		var outcome: Dictionary = outcomes[i] as Dictionary
		var condition: Dictionary = outcome.get("condition", {}) as Dictionary
		var orientations: Array = condition.get("orientations", []) as Array
		var effect_row := HBoxContainer.new()
		effect_row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		effect_row.add_theme_constant_override("separation", 6)
		card.add_child(effect_row)
		if not orientations.is_empty():
			var icons := HBoxContainer.new()
			icons.add_theme_constant_override("separation", 2)
			icons.size_flags_vertical = Control.SIZE_SHRINK_BEGIN
			effect_row.add_child(icons)
			for raw_orientation in orientations.slice(0, 6):
				icons.add_child(_kyokoro_icon(String(raw_orientation), 22))
		var effect_text := Label.new()
		effect_text.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		effect_text.text = _localized_outcome_text(move_id, move_doc, i, outcome)
		effect_text.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		effect_text.max_lines_visible = 2
		effect_text.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
		effect_row.add_child(effect_text)

func _on_move_toggled(enabled: bool, move_id: String) -> void:
	_cancel_online_ready()
	if enabled:
		if selected_move_ids.size() >= MAX_MOVES:
			(move_checkboxes[move_id] as BaseButton).set_pressed_no_signal(false); return
		selected_move_ids.append(move_id)
	else: selected_move_ids.erase(move_id)
	_update_selection_state()
	if selected_moves_first: call_deferred("_rebuild_move_choices")

func _update_selection_state() -> void:
	if selection_count_label: selection_count_label.text = _tr_ui("selected_count", {"current":selected_move_ids.size(),"max":MAX_MOVES})
	if start_button:
		var waiting_online := not OnlineRelay.room.is_empty() and not OnlineRelay.is_ready_for_moves()
		var needs_initiative := OnlineRelay.is_ready_for_moves() and String(OnlineRelay.room.get("first_player_id", "")).is_empty()
		start_button.disabled = selected_move_ids.size() != MAX_MOVES or waiting_online or needs_initiative or online_waiting_to_start
		start_button.text = _tr_ui("waiting_ready") if online_waiting_to_start else (_tr_ui("online_waiting") if waiting_online else (_tr_ui("initiative_needed") if needs_initiative else (_tr_ui("ready_for_battle") if OnlineRelay.is_ready_for_moves() else _tr_ui("start_session"))))

func _start_session() -> void:
	if selected_move_ids.size() != MAX_MOVES or (not OnlineRelay.room.is_empty() and (not OnlineRelay.is_ready_for_moves() or String(OnlineRelay.room.get("first_player_id", "")).is_empty())): return
	if OnlineRelay.is_ready_for_moves():
		online_waiting_to_start = true
		OnlineRelay.set_battle_ready(true, {"pokemon_id":String(selected_pokemon.get("species_id", selected_pokemon.get("id", ""))), "move_ids":selected_move_ids.duplicate()})
		_update_selection_state()
		return
	_begin_session()


func _begin_session() -> void:
	OnlineRelay.reset_move_history()
	current_hp = int(selected_pokemon.get("max_hp",0)); previous_move_id = ""; turn_number = 1
	# Offline remains the original manual flow. In an online room the host opens
	# the first turn and the joining phone waits for that confirmed move.
	phase = "player" if not OnlineRelay.is_ready_for_moves() or OnlineRelay.player_id == String(OnlineRelay.room.get("first_player_id", "")) else "opponent"
	pending_opponent_reminders.clear(); pending_self_reminders.clear(); last_kyokoro_result = ""; last_resolved_effects.clear(); last_resolution_details.clear(); _show_play_page()


func _cancel_online_ready() -> void:
	if not online_waiting_to_start: return
	online_waiting_to_start = false
	if OnlineRelay.is_ready_for_moves(): OnlineRelay.set_battle_ready(false)

func _show_play_page() -> void:
	showing_play_page = true
	last_layout_signature = _layout_signature()
	_clear_page()
	_build_play_toolbar()
	if status_details_expanded:
		_build_status_header()
	_build_reminder_area()
	play_moves_grid = GridContainer.new()
	play_moves_grid.columns = _play_card_columns()
	play_moves_grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	play_moves_grid.add_theme_constant_override("h_separation",12)
	play_moves_grid.add_theme_constant_override("v_separation",12)
	page.add_child(play_moves_grid)
	for move_id in selected_move_ids:
		if move_docs.has(move_id): play_moves_grid.add_child(_create_move_card(move_id, move_docs[move_id]))
	_update_phase_ui()


func _build_play_toolbar() -> void:
	var panel := PanelContainer.new()
	panel.add_theme_stylebox_override("panel", _panel_style(Color("0d131b"), 10, Color("29384a"), 1))
	page.add_child(panel)
	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 10)
	margin.add_theme_constant_override("margin_right", 10)
	margin.add_theme_constant_override("margin_top", 7)
	margin.add_theme_constant_override("margin_bottom", 7)
	panel.add_child(margin)
	var row := HBoxContainer.new()
	row.add_theme_constant_override("separation", 8)
	margin.add_child(row)

	var toggle := Button.new()
	toggle.text = _tr_ui("hide_info") if status_details_expanded else _tr_ui("show_info")
	toggle.tooltip_text = _tr_ui("info_tooltip")
	toggle.custom_minimum_size = Vector2(132, 40)
	toggle.pressed.connect(_toggle_status_details)
	row.add_child(toggle)

	var phase_summary := Label.new()
	phase_summary.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	phase_summary.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	phase_summary.text = _tr_ui("your_turn_short", {"turn":turn_number}) if phase == "player" else _tr_ui("opponent_turn_short", {"turn":turn_number})
	phase_summary.add_theme_font_size_override("font_size", 16)
	phase_summary.add_theme_color_override("font_color", Color("a8bdd3"))
	row.add_child(phase_summary)

	var end_game := Button.new()
	end_game.text = _tr_ui("end_game")
	end_game.custom_minimum_size = Vector2(125,40)
	end_game.pressed.connect(_end_session)
	row.add_child(end_game)

	language_option = OptionButton.new()
	language_option.custom_minimum_size = Vector2(155,40)
	var language_idx := 0
	var selected_language_idx := 0
	for label in LOCALES.keys():
		language_option.add_item(label)
		language_option.set_item_metadata(language_idx, LOCALES[label])
		if LOCALES[label] == current_locale: selected_language_idx = language_idx
		language_idx += 1
	language_option.select(selected_language_idx)
	language_option.item_selected.connect(_on_language_selected)
	row.add_child(language_option)

	var online_button := Button.new()
	online_button.text = _online_button_text()
	online_button.custom_minimum_size = Vector2(150,40)
	online_button.pressed.connect(_open_online_popup)
	row.add_child(online_button)
	online_status_buttons.append(online_button)

	var opponent_finished := Button.new()
	opponent_finished.text = _tr_ui("opponent_finished")
	opponent_finished.custom_minimum_size = Vector2(205,40)
	opponent_finished.visible = phase == "opponent" and OnlineRelay.room.is_empty()
	opponent_finished.pressed.connect(_confirm_opponent_turn_finished)
	row.add_child(opponent_finished)


func _toggle_status_details() -> void:
	status_details_expanded = not status_details_expanded
	_show_play_page()


func _end_session() -> void:
	online_waiting_to_start = false
	if OnlineRelay.is_ready_for_moves(): OnlineRelay.reset_battle()
	_show_setup_page()


func _build_status_header() -> void:
	var panel := PanelContainer.new()
	panel.add_theme_stylebox_override("panel", _panel_style(Color("121b26"), 12, Color("39516a"), 1))
	page.add_child(panel)
	var outer := MarginContainer.new()
	outer.add_theme_constant_override("margin_left", 14)
	outer.add_theme_constant_override("margin_right", 14)
	outer.add_theme_constant_override("margin_top", 10)
	outer.add_theme_constant_override("margin_bottom", 10)
	panel.add_child(outer)
	var top := HBoxContainer.new()
	top.add_theme_constant_override("separation",16)
	outer.add_child(top)
	var image := TextureRect.new()
	image.custom_minimum_size = Vector2(120,120)
	image.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	image.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	var image_path := "res://assets/pokemon/images/%s.png" % String(selected_pokemon.get("id",""))
	if ResourceLoader.exists(image_path): image.texture = load(image_path)
	top.add_child(image)
	var info := VBoxContainer.new()
	info.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	info.add_theme_constant_override("separation",5)
	top.add_child(info)
	var name_row := HBoxContainer.new()
	name_row.add_theme_constant_override("separation",10)
	info.add_child(name_row)
	var name := Label.new()
	name.text = _pokemon_name(selected_pokemon)
	name.add_theme_font_size_override("font_size",27)
	name.add_theme_color_override("font_color", Color("f6f9fc"))
	name_row.add_child(name)
	name_row.add_child(_energy_icon(String(selected_pokemon.get("pokemon_type", "normal")), 30))
	hp_label = Label.new()
	hp_label.add_theme_font_size_override("font_size",19)
	hp_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	hp_label.add_theme_color_override("font_color", Color("dce8f4"))
	name_row.add_child(hp_label)
	var hp_minus := Button.new()
	hp_minus.text = "−10"
	hp_minus.tooltip_text = _tr_ui("reduce_hp")
	hp_minus.custom_minimum_size = Vector2(70,42)
	hp_minus.pressed.connect(_adjust_hp.bind(-10))
	name_row.add_child(hp_minus)
	var hp_plus := Button.new()
	hp_plus.text = "+10"
	hp_plus.tooltip_text = _tr_ui("restore_hp")
	hp_plus.custom_minimum_size = Vector2(70,42)
	hp_plus.pressed.connect(_adjust_hp.bind(10))
	name_row.add_child(hp_plus)
	var weaknesses := HBoxContainer.new()
	weaknesses.add_theme_constant_override("separation",8)
	info.add_child(weaknesses)
	var weak_title := Label.new()
	weak_title.text = _tr_ui("weakness")
	weak_title.add_theme_color_override("font_color", Color("aebfd0"))
	weaknesses.add_child(weak_title)
	var weak_list: Array = selected_pokemon.get("weaknesses",[]) as Array
	if weak_list.is_empty():
		var none := Label.new(); none.text = "—"; weaknesses.add_child(none)
	else:
		for raw in weak_list:
			var weak: Dictionary = raw as Dictionary
			var type_id := String(weak.get("attack_type",""))
			weaknesses.add_child(_energy_icon(type_id,30))
			var bonus := Label.new()
			bonus.text = "+%d" % int(weak.get("bonus_damage",0))
			bonus.tooltip_text = _tr_ui("weakness_tooltip", {"type":_type_name(type_id)})
			bonus.add_theme_color_override("font_color", Color("ffd47a"))
			weaknesses.add_child(bonus)
	phase_label = Label.new()
	phase_label.add_theme_font_size_override("font_size",18)
	phase_label.add_theme_color_override("font_color", Color("a8c7e8"))
	info.add_child(phase_label)
	if not last_kyokoro_result.is_empty():
		var result_line := HBoxContainer.new()
		result_line.add_theme_constant_override("separation",7)
		info.add_child(result_line)
		var result_text := Label.new()
		result_text.text = _tr_ui("last_charakoro", {"result":_tr_ui("roll_failed_ignored") if last_kyokoro_result == "ENEKORO_FAILED" else _orientation_display_name(last_kyokoro_result)})
		result_text.add_theme_color_override("font_color", Color("c7d4e2"))
		result_line.add_child(result_text)
		if not last_resolved_effects.is_empty():
			var active := Label.new()
			active.text = _tr_ui("triggered", {"effects":" / ".join(PackedStringArray(last_resolved_effects))})
			active.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
			active.add_theme_color_override("font_color", Color("ffd47a"))
			info.add_child(active)


func _build_reminder_area() -> void:
	reminder_box = VBoxContainer.new(); reminder_box.add_theme_constant_override("separation",6); page.add_child(reminder_box)

func _refresh_reminders() -> void:
	if reminder_box == null: return
	for child in reminder_box.get_children(): reminder_box.remove_child(child); child.queue_free()
	var list := pending_opponent_reminders if phase == "opponent" else pending_self_reminders
	if list.is_empty(): return
	var panel := PanelContainer.new(); panel.add_theme_stylebox_override("panel", _panel_style(Color("4a3e1f"),8,Color("8d7837"),1)); reminder_box.add_child(panel)
	var margin := MarginContainer.new(); margin.add_theme_constant_override("margin_left",12); margin.add_theme_constant_override("margin_right",12); margin.add_theme_constant_override("margin_top",9); margin.add_theme_constant_override("margin_bottom",9); panel.add_child(margin)
	var box := VBoxContainer.new(); box.add_theme_constant_override("separation",4); margin.add_child(box)
	var title := Label.new(); title.text = _tr_ui("active_effect"); title.add_theme_font_size_override("font_size",17); box.add_child(title)
	for reminder in list:
		var line := Label.new(); line.text = "• %s%s" % [String(reminder.get("text","")), _orientation_suffix(reminder)]; line.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART; box.add_child(line)

func _play_card_columns() -> int:
	var viewport_size := get_viewport_rect().size
	# Desktop / large landscape: all four move cards in one row.
	# Phone/smaller landscape: 2x2, keeping card text large enough to read.
	if viewport_size.x >= 1500.0 and viewport_size.y >= 620.0: return 4
	if viewport_size.x >= 760.0: return 2
	return 1

func _setup_move_columns() -> int:
	var width := get_viewport_rect().size.x
	if width >= 2400.0: return 4
	if width >= 1600.0: return 3
	if width >= 1000.0: return 2
	return 1

func _layout_signature() -> String:
	if showing_play_page:
		return "play:%d" % _play_card_columns()
	return "setup:%d" % _setup_move_columns()

func _on_viewport_size_changed() -> void:
	if page != null:
		page.custom_minimum_size.y = maxf(0.0, get_viewport_rect().size.y - 28.0)
	if layout_refresh_pending: return
	if _layout_signature() == last_layout_signature: return
	layout_refresh_pending = true
	call_deferred("_refresh_responsive_layout")

func _refresh_responsive_layout() -> void:
	layout_refresh_pending = false
	if _layout_signature() == last_layout_signature: return
	if showing_play_page:
		_show_play_page()
	else:
		_show_setup_page()


func _create_move_card(move_id: String, move_doc: Dictionary) -> Control:
	var button := Button.new()
	button.name = "MoveCard_%s" % move_id
	button.text = ""
	var columns := _play_card_columns()
	var usable_width := maxf(360.0, get_viewport_rect().size.x - 64.0)
	var estimated_width := (usable_width - float(maxi(0, columns - 1)) * 12.0) / float(columns)
	# Keep the original ~2:1 physical-card ratio, but cap the height so four
	# cards remain readable in common 16:9–20:9 landscape viewports.
	var card_height := clampf(estimated_width * 302.0 / 606.0, 178.0, 286.0)
	button.custom_minimum_size = Vector2(300, card_height)
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.focus_mode = Control.FOCUS_ALL
	button.pressed.connect(_open_move_popup.bind(move_id))
	button.add_theme_stylebox_override("normal", _transparent_card_button_style(Color("5b7691"), 2))
	button.add_theme_stylebox_override("hover", _transparent_card_button_style(Color("8fc7ff"), 3))
	button.add_theme_stylebox_override("pressed", _transparent_card_button_style(Color("d7ecff"), 3))
	button.add_theme_stylebox_override("disabled", _transparent_card_button_style(Color("303a46"), 1))

	var card := _build_real_move_card(move_id, move_doc, false)
	card.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	card.offset_left = 6.0
	card.offset_top = 6.0
	card.offset_right = -6.0
	card.offset_bottom = -6.0
	button.add_child(card)

	if phase != "player" or move_id == previous_move_id:
		button.disabled = true
		var overlay := ColorRect.new()
		overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
		overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		overlay.color = Color(0.02,0.02,0.025,0.58)
		button.add_child(overlay)
		var locked := Label.new()
		locked.mouse_filter = Control.MOUSE_FILTER_IGNORE
		locked.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
		locked.offset_left = -170.0
		locked.offset_top = -24.0
		locked.offset_right = 170.0
		locked.offset_bottom = 24.0
		locked.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		locked.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		locked.add_theme_font_size_override("font_size", 19)
		locked.add_theme_color_override("font_color", Color.WHITE)
		locked.add_theme_color_override("font_outline_color", Color.BLACK)
		locked.add_theme_constant_override("outline_size", 5)
		if phase != "player":
			locked.text = _tr_ui("waiting_opponent")
		else:
			locked.text = _tr_ui("locked_last_turn")
			button.tooltip_text = _tr_ui("locked_tooltip")
		button.add_child(locked)
	return button


func _build_real_move_card(move_id: String, move_doc: Dictionary, large: bool, compact_selection := false, pokemon_override: Dictionary = {}) -> Control:
	# This layout is intentionally derived from the original V2.2
	# PlakoroMoveButton.gd renderer and uses the same background.png asset.
	var root := Control.new()
	root.name = "GeneratedMoveCard"
	root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	root.clip_contents = true
	root.custom_minimum_size = Vector2(760, 379) if large else Vector2(300, 178)

	var background := TextureRect.new()
	background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	background.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	background.stretch_mode = TextureRect.STRETCH_SCALE
	if ResourceLoader.exists(MOVE_CARD_BACKGROUND): background.texture = load(MOVE_CARD_BACKGROUND)
	background.modulate = _attack_type_card_color(String(move_doc.get("attack_type","normal")))
	root.add_child(background)

	var sheen := ColorRect.new()
	sheen.mouse_filter = Control.MOUSE_FILTER_IGNORE
	sheen.color = Color(1,1,1,0.08)
	_set_fractional_rect(sheen, Vector4(0.0,0.0,1.0,0.49))
	root.add_child(sheen)

	var attack_icon := _energy_icon(String(move_doc.get("attack_type","normal")), 70 if large else (42 if compact_selection else 50))
	_set_fractional_rect(attack_icon, Vector4(0.025,0.05,0.145,0.34))
	root.add_child(attack_icon)

	var card_pokemon := pokemon_override if not pokemon_override.is_empty() else selected_pokemon
	_add_card_label(root, _pokemon_name(card_pokemon), Vector4(0.16,0.035,0.68,0.17), 20 if large else (14 if compact_selection else 16), HORIZONTAL_ALIGNMENT_LEFT, Color.WHITE, 2)
	_add_card_label(root, _move_name(move_doc), Vector4(0.14,0.15,0.80,0.43), 38 if large else (26 if compact_selection else 30), HORIZONTAL_ALIGNMENT_CENTER, Color.WHITE, 5 if large else 3)
	var printed_damage = move_doc.get("printed_damage", null)
	var damage_value := _format_damage_value(printed_damage)
	var damage_label := _add_card_label(root, damage_value, Vector4(0.79,0.11,0.98,0.44), 48 if large else (36 if compact_selection else 42), HORIZONTAL_ALIGNMENT_CENTER, Color(1.0,0.25,0.20), 5 if large else 4, Color.WHITE)
	if printed_damage != null:
		damage_label.add_theme_font_override("font", FONT_NINJA_ATTACK)
	_add_card_energy_icons(root, move_doc, large, compact_selection)
	_add_card_effect_rows(root, move_id, move_doc, large, compact_selection)

	var source: Dictionary = move_doc.get("source", {}) as Dictionary
	var card_code := String(source.get("card_code", "")).strip_edges()
	if not card_code.is_empty() and not compact_selection:
		_add_card_label(root, card_code, Vector4(0.76,0.87,0.96,0.98), 11 if large else 8, HORIZONTAL_ALIGNMENT_RIGHT, Color(0.84,0.87,0.92,0.92), 1)
	return root


func _add_card_energy_icons(parent: Control, move_doc: Dictionary, large: bool, compact_selection := false) -> void:
	var costs := HBoxContainer.new()
	costs.mouse_filter = Control.MOUSE_FILTER_IGNORE
	costs.alignment = BoxContainer.ALIGNMENT_END
	costs.add_theme_constant_override("separation", 2)
	var total := 0
	for raw in move_doc.get("energy_cost",[]) as Array:
		total += maxi(0, int((raw as Dictionary).get("count",0)))
	var left := 0.60
	if total >= 5: left = 0.52
	if total >= 7: left = 0.44
	_set_fractional_rect(costs, Vector4(left,0.02,0.97,0.17))
	parent.add_child(costs)
	for raw in move_doc.get("energy_cost",[]) as Array:
		var cost: Dictionary = raw as Dictionary
		var count := maxi(0, int(cost.get("count",0)))
		for _i in range(count):
			costs.add_child(_energy_icon(String(cost.get("energy_type","normal")), 30 if large else (20 if compact_selection else 24)))


func _add_card_effect_rows(parent: Control, move_id: String, move_doc: Dictionary, large: bool, compact_selection := false) -> void:
	var outcomes := _move_outcome_rules(move_doc)
	var move_effect := _move_effect_text(move_id, move_doc)
	if not move_effect.is_empty():
		var strip := PanelContainer.new()
		strip.mouse_filter = Control.MOUSE_FILTER_IGNORE
		var energy_color := _attack_type_card_color(String(move_doc.get("attack_type", "normal")))
		strip.add_theme_stylebox_override("panel", _panel_style(energy_color, 0, Color.TRANSPARENT, 0))
		_set_fractional_rect(strip, Vector4(0.0,0.43,1.0,0.60))
		parent.add_child(strip)
		var strip_margin := MarginContainer.new()
		strip_margin.mouse_filter = Control.MOUSE_FILTER_IGNORE
		strip_margin.add_theme_constant_override("margin_left", 18 if large else 9)
		strip_margin.add_theme_constant_override("margin_right", 18 if large else 9)
		strip_margin.add_theme_constant_override("margin_top", 3)
		strip_margin.add_theme_constant_override("margin_bottom", 3)
		strip.add_child(strip_margin)
		var move_effect_label := Label.new()
		move_effect_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
		move_effect_label.text = move_effect
		move_effect_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		move_effect_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		move_effect_label.max_lines_visible = 2
		move_effect_label.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
		move_effect_label.add_theme_font_size_override("font_size", 25 if large else (15 if compact_selection else 20))
		var use_dark_text := energy_color.get_luminance() >= 0.46
		var effect_font_color := Color("07131d") if use_dark_text else Color.WHITE
		var effect_outline_color := Color(1.0,1.0,1.0,0.42) if use_dark_text else Color(0.0,0.0,0.0,0.94)
		move_effect_label.add_theme_color_override("font_color", effect_font_color)
		move_effect_label.add_theme_color_override("font_outline_color", effect_outline_color)
		move_effect_label.add_theme_constant_override("outline_size", 1 if use_dark_text else (3 if large else 2))
		strip_margin.add_child(move_effect_label)

	var effects := VBoxContainer.new()
	effects.mouse_filter = Control.MOUSE_FILTER_IGNORE
	effects.add_theme_constant_override("separation", 6 if large else 3)
	# Keep both the Charakoro face icons and their text fully inside the
	# lower black card area, whether or not the card has a Move Effect strip.
	_set_fractional_rect(effects, Vector4(0.025,0.57 if compact_selection else 0.61,0.965,0.98))
	parent.add_child(effects)
	if outcomes.is_empty():
		if move_effect.is_empty():
			var description := Label.new()
			description.mouse_filter = Control.MOUSE_FILTER_IGNORE
			description.text = _move_description(move_doc)
			description.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
			description.max_lines_visible = 5
			description.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
			description.add_theme_font_size_override("font_size", 25 if large else (15 if compact_selection else 18))
			description.add_theme_color_override("font_color", Color.WHITE)
			description.add_theme_color_override("font_outline_color", Color(0.02,0.03,0.05,0.95))
			description.add_theme_constant_override("outline_size", 2)
			effects.add_child(description)
		return
	for i in outcomes.size():
		var outcome: Dictionary = outcomes[i] as Dictionary
		var condition: Dictionary = outcome.get("condition",{}) as Dictionary
		var orientations: Array = condition.get("orientations",[]) as Array
		var row := HBoxContainer.new()
		row.mouse_filter = Control.MOUSE_FILTER_IGNORE
		row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		row.custom_minimum_size.y = 32.0 if large else (18.0 if compact_selection else 24.0)
		row.add_theme_constant_override("separation", 9 if large else 5)
		effects.add_child(row)

		# On-card Charakoro trigger faces come from the original V2.2 assets.
		# The result-selection popup intentionally remains text-only.
		if not orientations.is_empty():
			var icons := GridContainer.new()
			icons.columns = 3
			icons.mouse_filter = Control.MOUSE_FILTER_IGNORE
			icons.custom_minimum_size.x = 112.0 if large else 68.0
			icons.size_flags_vertical = Control.SIZE_SHRINK_CENTER
			icons.add_theme_constant_override("h_separation", 2)
			icons.add_theme_constant_override("v_separation", 2)
			row.add_child(icons)
			for raw_orientation in orientations.slice(0,6):
				icons.add_child(_kyokoro_icon(String(raw_orientation), 32 if large else (20 if compact_selection else 24)))

		var line := Label.new()
		line.mouse_filter = Control.MOUSE_FILTER_IGNORE
		line.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		line.size_flags_vertical = Control.SIZE_EXPAND_FILL
		line.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		line.text = _localized_outcome_text(move_id, move_doc, i, outcome)
		line.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		line.max_lines_visible = 4 if large else (3 if compact_selection else (3 if outcomes.size() <= 2 else 2))
		line.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
		var compact_font_size := 15 if outcomes.size() <= 1 else 13
		if compact_selection and line.text.length() > 115: compact_font_size = 13
		line.add_theme_font_size_override("font_size", 25 if large else (compact_font_size if compact_selection else 20))
		line.add_theme_color_override("font_color", Color.WHITE)
		line.add_theme_color_override("font_outline_color", Color(0.02,0.03,0.05,0.95))
		line.add_theme_constant_override("outline_size", 2)
		row.add_child(line)

func _update_phase_ui() -> void:
	if hp_label: hp_label.text = "HP %d / %d" % [current_hp,int(selected_pokemon.get("max_hp",0))]
	if phase_label:
		phase_label.text = _tr_ui("your_turn", {"turn":turn_number}) if phase == "player" else _tr_ui("opponent_turn", {"turn":turn_number})
	_refresh_reminders()

func _open_move_popup(move_id: String) -> void:
	if phase != "player" or move_id == previous_move_id or not move_docs.has(move_id): return
	var move_doc: Dictionary = move_docs[move_id]
	var popup := PopupPanel.new()
	popup.exclusive = true
	popup.transparent_bg = false
	add_child(popup)
	popup.popup_hide.connect(func(): popup.queue_free())
	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left",12)
	margin.add_theme_constant_override("margin_right",12)
	margin.add_theme_constant_override("margin_top",12)
	margin.add_theme_constant_override("margin_bottom",12)
	popup.add_child(margin)
	var content := HBoxContainer.new()
	content.add_theme_constant_override("separation",16)
	margin.add_child(content)
	var preview := _build_real_move_card(move_id, move_doc, true)
	preview.custom_minimum_size = Vector2(760,379)
	content.add_child(preview)
	var decision := VBoxContainer.new()
	decision.custom_minimum_size = Vector2(330, 0)
	decision.size_flags_vertical = Control.SIZE_EXPAND_FILL
	decision.add_theme_constant_override("separation",10)
	content.add_child(decision)
	_build_energy_step(decision, popup, move_id, move_doc)
	_show_popup_at_size(popup, Vector2i(1145, 425))


func _build_energy_step(decision: VBoxContainer, popup: PopupPanel, move_id: String, move_doc: Dictionary) -> void:
	_clear_container(decision)
	var title := Label.new()
	title.text = _tr_ui("resolve_roll")
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 22)
	decision.add_child(title)
	var hint := Label.new()
	hint.text = _tr_ui("roll_hint")
	hint.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	hint.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	hint.modulate = Color(0.78,0.82,0.88)
	decision.add_child(hint)
	var spacer := Control.new(); spacer.size_flags_vertical = Control.SIZE_EXPAND_FILL; decision.add_child(spacer)
	var failed := Button.new()
	failed.text = _tr_ui("enerkoro_failed")
	failed.custom_minimum_size = Vector2(0, 52)
	failed.pressed.connect(func(): popup.hide(); _finalize_move_use(move_id, "ENEKORO_FAILED", []))
	decision.add_child(failed)
	var success := Button.new()
	success.text = _tr_ui("energy_succeeded")
	success.custom_minimum_size = Vector2(0, 52)
	success.add_theme_stylebox_override("normal", _ui_button_style(Color("167a67"), Color("56d6b9"), 2))
	success.pressed.connect(func():
		var outcomes := _move_outcome_rules(move_doc)
		if outcomes.is_empty():
			popup.hide()
			_finalize_move_use(move_id, "", [])
		else:
			_build_charakoro_step(decision, popup, move_id, move_doc)
	)
	decision.add_child(success)
	var cancel_button := Button.new()
	cancel_button.text = _tr_ui("cancel")
	cancel_button.custom_minimum_size = Vector2(0,46)
	cancel_button.pressed.connect(popup.hide)
	decision.add_child(cancel_button)


func _build_charakoro_step(decision: VBoxContainer, popup: PopupPanel, move_id: String, move_doc: Dictionary) -> void:
	_clear_container(decision)
	var title := Label.new(); title.text = _tr_ui("select_face"); title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER; title.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART; title.add_theme_font_size_override("font_size", 20); decision.add_child(title)
	var subtitle := Label.new(); subtitle.text = _tr_ui("card_stays_visible"); subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER; subtitle.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART; subtitle.modulate = Color("b8c7d8"); decision.add_child(subtitle)
	var grid := GridContainer.new(); grid.columns = 2; grid.add_theme_constant_override("h_separation",8); grid.add_theme_constant_override("v_separation",8); decision.add_child(grid)
	for orientation in ["HEAD_UP","HEAD_DOWN","HEAD_LEFT","HEAD_RIGHT","FACE_UP","FACE_DOWN"]:
		var button := Button.new()
		button.custom_minimum_size = Vector2(155, 58)
		button.text = _orientation_display_name(orientation)
		button.icon = _kyokoro_button_texture(orientation, 38)
		button.expand_icon = false
		button.clip_text = true
		button.pressed.connect(_on_kyokoro_choice.bind(popup, move_id, move_doc, orientation))
		grid.add_child(button)
	var back := Button.new(); back.text = _tr_ui("back_to_energy"); back.custom_minimum_size = Vector2(0,44); back.pressed.connect(_build_energy_step.bind(decision, popup, move_id, move_doc)); decision.add_child(back)


func _clear_container(container: Container) -> void:
	for child in container.get_children():
		container.remove_child(child)
		child.queue_free()


func _confirm_use_move(move_id: String) -> void:
	if not move_docs.has(move_id) or phase != "player" or move_id == previous_move_id: return
	var move_doc: Dictionary = move_docs[move_id]
	var outcomes := _move_outcome_rules(move_doc)
	if outcomes.is_empty():
		_finalize_move_use(move_id, "", [])
		return
	_open_kyokoro_result_popup(move_id, move_doc)


func _open_kyokoro_result_popup(move_id: String, move_doc: Dictionary) -> void:
	var popup := PopupPanel.new()
	popup.name = "CharakoroResultPopup"
	popup.exclusive = true
	popup.transparent_bg = false
	# Use an explicit opaque style so the game cards do not show through the dialog.
	popup.add_theme_stylebox_override("panel", _panel_style(Color("15181d"), 14, Color("555b66"), 1))
	add_child(popup)
	popup.popup_hide.connect(func(): popup.queue_free())

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 16)
	margin.add_theme_constant_override("margin_right", 16)
	margin.add_theme_constant_override("margin_top", 14)
	margin.add_theme_constant_override("margin_bottom", 14)
	popup.add_child(margin)

	var box := VBoxContainer.new()
	box.add_theme_constant_override("separation", 9)
	margin.add_child(box)

	var title := Label.new()
	title.text = _tr_ui("resolve_roll")
	title.add_theme_font_size_override("font_size", 22)
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	box.add_child(title)

	var subtitle := Label.new()
	subtitle.text = _tr_ui("resolve_subtitle")
	subtitle.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	subtitle.add_theme_font_size_override("font_size", 15)
	subtitle.modulate = Color(0.82,0.85,0.90)
	box.add_child(subtitle)

	var failed := Button.new()
	failed.text = _tr_ui("enerkoro_failed")
	failed.custom_minimum_size = Vector2(0, 42)
	failed.add_theme_font_size_override("font_size", 16)
	failed.pressed.connect(func(): popup.hide(); _finalize_move_use(move_id, "ENEKORO_FAILED", []))
	box.add_child(failed)

	var success_label := Label.new()
	success_label.text = _tr_ui("select_face")
	success_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	success_label.add_theme_font_size_override("font_size", 16)
	box.add_child(success_label)

	var grid := GridContainer.new()
	grid.columns = 3
	grid.add_theme_constant_override("h_separation", 8)
	grid.add_theme_constant_override("v_separation", 8)
	box.add_child(grid)
	for orientation in ["HEAD_UP","HEAD_DOWN","HEAD_LEFT","HEAD_RIGHT","FACE_UP","FACE_DOWN"]:
		var b := Button.new()
		b.custom_minimum_size = Vector2(205, 54)
		b.text = _orientation_display_name(orientation)
		b.add_theme_font_size_override("font_size", 16)
		b.icon = _kyokoro_button_texture(orientation, 38)
		# Long translations (especially Spanish) must not consume the icon's
		# entire allocation. Keep every face visible and clip only excess text.
		b.expand_icon = false
		b.clip_text = true
		b.pressed.connect(_on_kyokoro_choice.bind(popup, move_id, move_doc, orientation))
		grid.add_child(b)

	margin.custom_minimum_size.x = 665.0
	_show_popup_at_size(popup, Vector2i(695, 350))

func _on_kyokoro_choice(popup: PopupPanel, move_id: String, move_doc: Dictionary, orientation: String) -> void:
	popup.hide()
	_resolve_kyokoro_and_finalize(move_id, move_doc, orientation)


func _resolve_kyokoro_and_finalize(move_id: String, move_doc: Dictionary, orientation: String) -> void:
	var matched: Array[Dictionary] = []
	var outcomes := _move_outcome_rules(move_doc)
	for i in outcomes.size():
		var outcome: Dictionary = outcomes[i] as Dictionary
		var condition: Dictionary = outcome.get("condition",{}) as Dictionary
		var orientations: Array = condition.get("orientations",[]) as Array
		if orientation in orientations:
			matched.append({"index":i,"outcome":outcome})
	_finalize_move_use(move_id, orientation, matched)


func _finalize_move_use(move_id: String, orientation: String, matched: Array[Dictionary]) -> void:
	if not move_docs.has(move_id): return
	var move_doc: Dictionary = move_docs[move_id]
	var move_failed := orientation == "ENEKORO_FAILED"
	pending_self_reminders.clear()
	pending_opponent_reminders.clear()
	last_kyokoro_result = orientation
	last_resolved_effects.clear()
	last_resolution_details = {}
	if not move_failed:
		var fixed_move_effect := _move_effect_text(move_id, move_doc)
		if not fixed_move_effect.is_empty():
			last_resolved_effects.append(fixed_move_effect)
			var source: Dictionary = move_doc.get("source", {}) as Dictionary
			var raw_move_effect := " ".join(PackedStringArray(source.get("move_effect_text", []) as Array)).to_lower()
			var fixed_reminder := {"text":fixed_move_effect,"orientations":[]}
			if _effect_targets_opponent_next_turn(raw_move_effect): pending_opponent_reminders.append(fixed_reminder)
			if _effect_targets_self_next_turn(raw_move_effect): pending_self_reminders.append(fixed_reminder)
		for item in matched:
			var idx := int(item.get("index",0))
			var outcome: Dictionary = item.get("outcome",{}) as Dictionary
			var localized := _localized_outcome_text(move_id, move_doc, idx, outcome)
			last_resolved_effects.append(localized)
			var raw := String(outcome.get("raw_text","")).to_lower()
			var reminder := {"text":localized,"orientations":[orientation]}
			if _effect_targets_opponent_next_turn(raw): pending_opponent_reminders.append(reminder)
			if _effect_targets_self_next_turn(raw): pending_self_reminders.append(reminder)
	var total_damage: Variant = 0 if move_failed else _calculate_total_damage(move_doc, matched)
	if not move_failed:
		last_resolution_details = _calculate_resolution_details(move_doc, matched)
	_publish_online_move(move_id, orientation, total_damage, move_failed)
	previous_move_id = move_id
	phase = "opponent"
	_show_play_page()
	call_deferred("_show_move_result_popup", move_id, total_damage, move_failed)

func _calculate_total_damage(move_doc: Dictionary, matched: Array[Dictionary]) -> Variant:
	var printed_damage = move_doc.get("printed_damage", null)
	var has_known_total := printed_damage != null
	var total := float(printed_damage) if has_known_total else 0.0
	for item in matched:
		var outcome: Dictionary = item.get("outcome", {}) as Dictionary
		for raw_action in outcome.get("actions", []) as Array:
			var action: Dictionary = raw_action as Dictionary
			var opcode := String(action.get("opcode", ""))
			var args: Dictionary = action.get("args", {}) as Dictionary
			var target := String(args.get("target", "opponent"))
			if target == "self":
				continue
			match opcode:
				"damage.add":
					if has_known_total: total += float(args.get("amount", 0))
				"damage.set":
					total = float(args.get("amount", 0)); has_known_total = true
				"damage.multiply":
					if has_known_total: total *= float(args.get("factor", 1.0))
				"damage.add_per_energy":
					has_known_total = false
	return int(round(total)) if has_known_total else null


func _calculate_resolution_details(move_doc: Dictionary, matched: Array[Dictionary]) -> Dictionary:
	var details := {"self_damage":0, "self_heal":0, "incoming_reduction":0, "incoming_immunity":false}
	for raw_action in move_doc.get("base_actions", []) as Array:
		_accumulate_resolution_action(details, raw_action as Dictionary)
	for item in matched:
		var outcome: Dictionary = item.get("outcome", {}) as Dictionary
		for raw_action in outcome.get("actions", []) as Array:
			_accumulate_resolution_action(details, raw_action as Dictionary)
	return details


func _accumulate_resolution_action(details: Dictionary, action: Dictionary) -> void:
	var opcode := String(action.get("opcode", ""))
	var args: Dictionary = action.get("args", {}) as Dictionary
	var target := String(args.get("target", ""))
	var amount := int(round(float(args.get("amount", 0))))
	match opcode:
		"damage.recoil": details["self_damage"] = int(details.get("self_damage", 0)) + absi(amount)
		"damage.create", "damage.add":
			if target == "self": details["self_damage"] = int(details.get("self_damage", 0)) + absi(amount)
		"hp.restore":
			if target == "self": details["self_heal"] = int(details.get("self_heal", 0)) + absi(amount)
		"incoming_damage.modify":
			if target == "self" and amount < 0: details["incoming_reduction"] = int(details.get("incoming_reduction", 0)) + absi(amount)
		"incoming_damage.immunity":
			if target == "self" or target.is_empty(): details["incoming_immunity"] = true

func _show_move_result_popup(move_id: String, total_damage: Variant, move_failed: bool) -> void:
	if not move_docs.has(move_id): return
	var popup := PopupPanel.new()
	popup.name = "MoveResultPopup"
	popup.exclusive = true
	popup.transparent_bg = false
	popup.add_theme_stylebox_override("panel", _panel_style(Color("111821"), 14, Color("56728d"), 2))
	add_child(popup)
	popup.popup_hide.connect(func(): popup.queue_free())
	var margin := MarginContainer.new()
	for side in ["left", "right"]: margin.add_theme_constant_override("margin_%s" % side, 22)
	for side in ["top", "bottom"]: margin.add_theme_constant_override("margin_%s" % side, 18)
	popup.add_child(margin)
	var box := VBoxContainer.new(); box.add_theme_constant_override("separation", 11); margin.add_child(box)
	var result_scroll := ScrollContainer.new()
	result_scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	result_scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	result_scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	_configure_touch_scrollbar(result_scroll)
	box.add_child(result_scroll)
	var content := VBoxContainer.new()
	content.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	content.add_theme_constant_override("separation", 11)
	var result_content_margin := MarginContainer.new()
	result_content_margin.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	result_content_margin.add_theme_constant_override("margin_right", 38)
	result_scroll.add_child(result_content_margin)
	result_content_margin.add_child(content)
	var title := Label.new(); title.text = _tr_ui("resolution_title"); title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER; title.add_theme_font_size_override("font_size", 26); content.add_child(title)
	var move_name := Label.new(); move_name.text = _move_name(move_docs[move_id]); move_name.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER; move_name.add_theme_font_size_override("font_size", 21); move_name.add_theme_color_override("font_color", Color("a9c8e8")); content.add_child(move_name)
	if move_failed:
		var failed := Label.new(); failed.text = _tr_ui("result_failed"); failed.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER; failed.add_theme_font_size_override("font_size", 22); failed.add_theme_color_override("font_color", Color("ff9a8c")); content.add_child(failed)
	else:
		var damage_title := Label.new(); damage_title.text = _tr_ui("result_total_damage"); damage_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER; damage_title.add_theme_color_override("font_color", Color("b8c7d8")); content.add_child(damage_title)
		var damage := Label.new(); damage.text = _format_damage_value(total_damage); damage.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER; damage.add_theme_font_override("font", FONT_NINJA_ATTACK); damage.add_theme_font_size_override("font_size", 58); damage.add_theme_color_override("font_color", Color("ff5548")); damage.add_theme_color_override("font_outline_color", Color.WHITE); damage.add_theme_constant_override("outline_size", 2); content.add_child(damage)
		if total_damage != null and int(total_damage) > 0:
			var weakness_damage := Label.new(); weakness_damage.text = _tr_ui("result_weakness_damage", {"value":int(total_damage) + 20}); weakness_damage.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER; weakness_damage.add_theme_font_size_override("font_size", 17); weakness_damage.add_theme_color_override("font_color", Color("ffd47a")); content.add_child(weakness_damage)
		var self_damage := int(last_resolution_details.get("self_damage", 0))
		var self_heal := int(last_resolution_details.get("self_heal", 0))
		var reduction := int(last_resolution_details.get("incoming_reduction", 0))
		if self_damage > 0: _add_result_notice(content, _tr_ui("result_self_damage", {"value":self_damage}), Color("ff9a8c"))
		if self_heal > 0: _add_result_notice(content, _tr_ui("result_heal", {"value":self_heal}), Color("78e0a8"))
		if reduction > 0: _add_result_notice(content, _tr_ui("result_reduction", {"value":reduction}), Color("8fc7ff"))
		if bool(last_resolution_details.get("incoming_immunity", false)): _add_result_notice(content, _tr_ui("result_immunity"), Color("8fc7ff"))
		var effects_title := Label.new(); effects_title.text = _tr_ui("result_effects"); effects_title.add_theme_font_size_override("font_size", 18); effects_title.add_theme_color_override("font_color", Color("ffd47a")); content.add_child(effects_title)
		if last_resolved_effects.is_empty():
			var none := Label.new(); none.text = _tr_ui("result_no_effect"); content.add_child(none)
		else:
			for effect in last_resolved_effects:
				var line := Label.new(); line.text = "• %s" % effect; line.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART; line.add_theme_font_size_override("font_size", 17); content.add_child(line)
	var close := Button.new(); close.text = _tr_ui("close"); close.custom_minimum_size = Vector2(210,48); close.pressed.connect(popup.hide); box.add_child(close)
	margin.custom_minimum_size.x = 580.0
	var result_height := 235
	if not move_failed:
		var extra_effect_lines := maxi(0, last_resolved_effects.size() - 1) * 42
		# Turn reminders remain visible on the battle page, so the result dialog
		# shows each resolved effect only once.
		result_height = clampi(420 + extra_effect_lines, 420, 600)
	_show_popup_at_size(popup, Vector2i(625, result_height))


func _add_result_notice(parent: VBoxContainer, value: String, color: Color) -> void:
	var notice := Label.new()
	notice.text = "◆ %s" % value
	notice.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	notice.add_theme_font_size_override("font_size", 18)
	notice.add_theme_color_override("font_color", color)
	parent.add_child(notice)


func _online_button_text() -> String:
	if OnlineRelay.state == &"reconnecting": return _tr_ui("online_reconnecting")
	if OnlineRelay.room.is_empty(): return _tr_ui("online")
	var code := String(OnlineRelay.room.get("code", ""))
	if int(OnlineRelay.room.get("connected_count", OnlineRelay.room.get("player_count", 0))) < 2:
		return _tr_ui("opponent_disconnected") if int(OnlineRelay.room.get("player_count", 0)) >= 2 else _tr_ui("online_waiting")
	return _tr_ui("online_ready", {"code":code})


func _open_online_popup() -> void:
	var popup := PopupPanel.new()
	popup.exclusive = true
	popup.add_theme_stylebox_override("panel", _panel_style(Color("111821"), 14, Color("56728d"), 2))
	add_child(popup)
	popup.popup_hide.connect(func(): popup.queue_free())
	var margin := MarginContainer.new()
	for side in ["left","right","top","bottom"]: margin.add_theme_constant_override("margin_%s" % side, 18)
	popup.add_child(margin)
	var box := VBoxContainer.new(); box.add_theme_constant_override("separation", 10); margin.add_child(box)
	var title := Label.new(); title.text = _tr_ui("online_title"); title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER; title.add_theme_font_size_override("font_size", 24); box.add_child(title)
	var hint := Label.new(); hint.text = _tr_ui("online_hint"); hint.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART; hint.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER; hint.modulate = Color("b8c7d8"); box.add_child(hint)
	var name_edit := LineEdit.new(); name_edit.placeholder_text = _tr_ui("online_name"); name_edit.text = "Player"; name_edit.custom_minimum_size.y = 44; box.add_child(name_edit)
	var server_edit := LineEdit.new(); server_edit.placeholder_text = _tr_ui("online_server"); server_edit.text = OnlineRelay.default_server_url(); server_edit.custom_minimum_size.y = 44; box.add_child(server_edit)
	var connect := Button.new(); connect.custom_minimum_size.y = 46; box.add_child(connect)
	var room_row := HBoxContainer.new(); room_row.add_theme_constant_override("separation", 8); box.add_child(room_row)
	var create := Button.new(); create.text = _tr_ui("online_create"); create.size_flags_horizontal = Control.SIZE_EXPAND_FILL; create.custom_minimum_size.y = 48; room_row.add_child(create)
	var join := Button.new(); join.text = _tr_ui("online_join"); join.size_flags_horizontal = Control.SIZE_EXPAND_FILL; join.custom_minimum_size.y = 48; room_row.add_child(join)
	var code_edit := LineEdit.new(); code_edit.max_length = 6; code_edit.visible = false; box.add_child(code_edit)
	var code_display := HBoxContainer.new(); code_display.alignment = BoxContainer.ALIGNMENT_CENTER; code_display.add_theme_constant_override("separation", 6); box.add_child(code_display)
	var energy_palette := HBoxContainer.new(); energy_palette.alignment = BoxContainer.ALIGNMENT_CENTER; energy_palette.add_theme_constant_override("separation", 4); box.add_child(energy_palette)
	for code in ONLINE_ENERGY_CODES:
		var energy_button := Button.new(); energy_button.custom_minimum_size = Vector2(46,46); energy_button.icon = _energy_texture(String(ONLINE_ENERGY_CODES[code])); energy_button.expand_icon = true; energy_button.tooltip_text = String(ONLINE_ENERGY_CODES[code]).capitalize(); energy_button.pressed.connect(_append_online_energy_code.bind(code_edit, code_display, code)); energy_palette.add_child(energy_button)
	var back_code := Button.new(); back_code.text = "⌫"; back_code.custom_minimum_size = Vector2(46,46); back_code.pressed.connect(_remove_online_energy_code.bind(code_edit, code_display)); energy_palette.add_child(back_code)
	var clear_code := Button.new(); clear_code.text = "×"; clear_code.custom_minimum_size = Vector2(46,46); clear_code.pressed.connect(_clear_online_energy_code.bind(code_edit, code_display)); energy_palette.add_child(clear_code)
	var status := Label.new(); status.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER; status.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART; box.add_child(status)
	var initiative_title := Label.new(); initiative_title.text = _tr_ui("initiative_title"); initiative_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER; initiative_title.add_theme_font_size_override("font_size", 18); box.add_child(initiative_title)
	var initiative_row := HBoxContainer.new(); initiative_row.add_theme_constant_override("separation", 8); box.add_child(initiative_row)
	var coin := Button.new(); coin.text = _tr_ui("coin_flip"); coin.size_flags_horizontal = Control.SIZE_EXPAND_FILL; coin.custom_minimum_size.y = 46; coin.pressed.connect(OnlineRelay.request_coin_flip); initiative_row.add_child(coin)
	var rps_row := HBoxContainer.new(); rps_row.add_theme_constant_override("separation", 8); box.add_child(rps_row)
	for choice in ["rock", "paper", "scissors"]:
		var choice_button := Button.new(); choice_button.text = _tr_ui(choice); choice_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL; choice_button.custom_minimum_size.y = 46; choice_button.pressed.connect(OnlineRelay.submit_rps.bind(choice)); rps_row.add_child(choice_button)
	var refresh := func():
		var connected := OnlineRelay.state == &"connected"
		connect.text = _tr_ui("online_disconnect") if connected else _tr_ui("online_connect")
		server_edit.editable = not connected
		create.disabled = not connected
		join.disabled = not connected
		var shown_code := String(OnlineRelay.room.get("code", "")) if not OnlineRelay.room.is_empty() else code_edit.text
		_render_online_energy_code(code_display, shown_code)
		energy_palette.visible = OnlineRelay.room.is_empty()
		join.visible = OnlineRelay.room.is_empty()
		create.visible = OnlineRelay.room.is_empty()
		var ready := OnlineRelay.is_ready_for_moves()
		coin.disabled = not ready or not String(OnlineRelay.room.get("first_player_id", "")).is_empty()
		for child in rps_row.get_children(): (child as Button).disabled = not ready or not String(OnlineRelay.room.get("first_player_id", "")).is_empty()
		status.text = _initiative_status_text() if ready else (_online_button_text() if connected else String(OnlineRelay.state).capitalize())
	refresh.call()
	connect.pressed.connect(func():
		if OnlineRelay.state == &"disconnected": OnlineRelay.connect_to_server(server_edit.text)
		else: OnlineRelay.disconnect_from_server()
	)
	create.pressed.connect(func(): OnlineRelay.create_room(name_edit.text))
	join.pressed.connect(func():
		if code_edit.text.strip_edges().length() != 6:
			status.text = _tr_ui("online_invalid_code")
			return
		OnlineRelay.join_room(code_edit.text, name_edit.text)
	)
	var state_callback := func(_state: StringName): refresh.call()
	var room_callback := func(_room: Dictionary): refresh.call()
	var initiative_callback := func(result: Dictionary):
		if String(result.get("type", "")) == "initiative_tie": status.text = _tr_ui("initiative_tie")
		elif String(result.get("type", "")) == "initiative_waiting": status.text = _tr_ui("initiative_waiting")
		else: refresh.call()
	OnlineRelay.connection_changed.connect(state_callback)
	OnlineRelay.room_changed.connect(room_callback)
	OnlineRelay.initiative_changed.connect(initiative_callback)
	popup.tree_exiting.connect(func():
		if OnlineRelay.connection_changed.is_connected(state_callback): OnlineRelay.connection_changed.disconnect(state_callback)
		if OnlineRelay.room_changed.is_connected(room_callback): OnlineRelay.room_changed.disconnect(room_callback)
		if OnlineRelay.initiative_changed.is_connected(initiative_callback): OnlineRelay.initiative_changed.disconnect(initiative_callback)
	)
	_show_popup_at_size(popup, Vector2i(650, 650))


func _append_online_energy_code(code_edit: LineEdit, display: HBoxContainer, code: String) -> void:
	if code_edit.text.length() >= 6: return
	code_edit.text += code
	_render_online_energy_code(display, code_edit.text)


func _remove_online_energy_code(code_edit: LineEdit, display: HBoxContainer) -> void:
	code_edit.text = code_edit.text.left(maxi(0, code_edit.text.length() - 1))
	_render_online_energy_code(display, code_edit.text)


func _clear_online_energy_code(code_edit: LineEdit, display: HBoxContainer) -> void:
	code_edit.text = ""
	_render_online_energy_code(display, "")


func _render_online_energy_code(display: HBoxContainer, code: String) -> void:
	for child in display.get_children():
		display.remove_child(child)
		child.queue_free()
	for index in 6:
		var slot := Button.new(); slot.custom_minimum_size = Vector2(52,52); slot.mouse_filter = Control.MOUSE_FILTER_IGNORE; slot.focus_mode = Control.FOCUS_NONE; slot.expand_icon = true
		var character := code.substr(index, 1) if index < code.length() else ""
		if ONLINE_ENERGY_CODES.has(character): slot.icon = _energy_texture(String(ONLINE_ENERGY_CODES[character]))
		else: slot.text = str(index + 1); slot.modulate = Color(1,1,1,0.5)
		display.add_child(slot)


func _publish_online_move(move_id: String, orientation: String, total_damage: Variant, move_failed: bool) -> void:
	if not OnlineRelay.is_ready_for_moves(): return
	online_sequence += 1
	OnlineRelay.publish_move({
		"protocol":1,
		"sequence":online_sequence,
		"move_id":move_id,
		"pokemon_id":String(selected_pokemon.get("species_id", selected_pokemon.get("id", ""))),
		"orientation":orientation,
		"move_failed":move_failed,
		"total_damage":total_damage,
		"details":last_resolution_details.duplicate(true)
	})


func _on_opponent_move_received(payload: Dictionary) -> void:
	var move_id := String(payload.get("move_id", ""))
	if not move_docs.has(move_id):
		_on_online_error("Unknown opponent move: %s" % move_id)
		return
	if phase == "opponent":
		phase = "player"
		turn_number += 1
		pending_opponent_reminders.clear()
		_show_play_page()
	call_deferred("_show_opponent_move_popup", payload)


func _show_opponent_move_popup(payload: Dictionary) -> void:
	var move_id := String(payload.get("move_id", ""))
	if not move_docs.has(move_id): return
	var move_doc: Dictionary = move_docs[move_id]
	var pokemon_doc := _find_pokemon_by_species(String(payload.get("pokemon_id", "")))
	var orientation := String(payload.get("orientation", ""))
	var move_failed := bool(payload.get("move_failed", false))
	var matched := _matched_outcomes_for_orientation(move_doc, orientation) if not move_failed else [] as Array[Dictionary]
	var effects: Array[String] = []
	if not move_failed:
		var fixed := _move_effect_text(move_id, move_doc)
		if not fixed.is_empty(): effects.append(fixed)
		for item in matched:
			var idx := int(item.get("index", 0)); var outcome := item.get("outcome", {}) as Dictionary
			effects.append(_localized_outcome_text(move_id, move_doc, idx, outcome))
	var popup := PopupPanel.new(); popup.exclusive = true; popup.add_theme_stylebox_override("panel", _panel_style(Color("10161d"), 14, Color("73a5ce"), 2)); add_child(popup); popup.popup_hide.connect(func(): popup.queue_free())
	var margin := MarginContainer.new(); for side in ["left","right","top","bottom"]: margin.add_theme_constant_override("margin_%s" % side, 14); popup.add_child(margin)
	var row := HBoxContainer.new(); row.add_theme_constant_override("separation", 16); margin.add_child(row)
	var card := _build_real_move_card(move_id, move_doc, true, false, pokemon_doc); card.custom_minimum_size = Vector2(700, 349); row.add_child(card)
	var side := VBoxContainer.new(); side.custom_minimum_size.x = 350; side.add_theme_constant_override("separation", 9); row.add_child(side)
	var title := Label.new(); title.text = _tr_ui("online_opponent_move"); title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER; title.add_theme_font_size_override("font_size", 24); side.add_child(title)
	var scroll := ScrollContainer.new(); scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL; scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED; _configure_touch_scrollbar(scroll); side.add_child(scroll)
	var results := VBoxContainer.new(); results.size_flags_horizontal = Control.SIZE_EXPAND_FILL; results.add_theme_constant_override("separation", 8); scroll.add_child(results)
	if move_failed:
		_add_result_notice(results, _tr_ui("result_failed"), Color("ff9a8c"))
	else:
		var total = payload.get("total_damage", null)
		var damage_title := Label.new(); damage_title.text = _tr_ui("result_total_damage"); damage_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER; results.add_child(damage_title)
		var damage := Label.new(); damage.text = _format_damage_value(total); damage.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER; damage.add_theme_font_override("font", FONT_NINJA_ATTACK); damage.add_theme_font_size_override("font_size", 54); damage.add_theme_color_override("font_color", Color("ff5548")); results.add_child(damage)
		if total != null and int(total) > 0: _add_result_notice(results, _tr_ui("result_weakness_damage", {"value":int(total) + 20}), Color("ffd47a"))
		var details := payload.get("details", {}) as Dictionary
		if int(details.get("self_damage", 0)) > 0: _add_result_notice(results, _tr_ui("result_self_damage", {"value":details.get("self_damage", 0)}), Color("ff9a8c"))
		if int(details.get("self_heal", 0)) > 0: _add_result_notice(results, _tr_ui("result_heal", {"value":details.get("self_heal", 0)}), Color("78e0a8"))
		if int(details.get("incoming_reduction", 0)) > 0: _add_result_notice(results, _tr_ui("result_reduction", {"value":details.get("incoming_reduction", 0)}), Color("8fc7ff"))
		if bool(details.get("incoming_immunity", false)): _add_result_notice(results, _tr_ui("result_immunity"), Color("8fc7ff"))
		var effects_title := Label.new(); effects_title.text = _tr_ui("result_effects"); effects_title.add_theme_color_override("font_color", Color("ffd47a")); results.add_child(effects_title)
		if effects.is_empty(): effects.append(_tr_ui("result_no_effect"))
		for effect in effects:
			var line := Label.new(); line.text = "• %s" % effect; line.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART; line.add_theme_font_size_override("font_size", 17); results.add_child(line)
	var close := Button.new(); close.text = _tr_ui("close"); close.custom_minimum_size.y = 48; close.pressed.connect(popup.hide); side.add_child(close)
	_show_popup_at_size(popup, Vector2i(1120, 430))


func _matched_outcomes_for_orientation(move_doc: Dictionary, orientation: String) -> Array[Dictionary]:
	var matched: Array[Dictionary] = []
	var outcomes := _move_outcome_rules(move_doc)
	for index in outcomes.size():
		var outcome := outcomes[index] as Dictionary
		if orientation in ((outcome.get("condition", {}) as Dictionary).get("orientations", []) as Array): matched.append({"index":index, "outcome":outcome})
	return matched


func _find_pokemon_by_species(species_id: String) -> Dictionary:
	for pokemon in pokemon_docs:
		if String(pokemon.get("species_id", pokemon.get("id", ""))) == species_id: return pokemon
	return selected_pokemon


func _on_online_error(message: String) -> void:
	var dialog := AcceptDialog.new(); dialog.title = _tr_ui("online_title"); dialog.dialog_text = message; add_child(dialog); dialog.popup_hide.connect(func(): dialog.queue_free()); dialog.popup_centered(Vector2i(520, 180))


func _on_online_room_changed(_room: Dictionary) -> void:
	_refresh_online_buttons()
	if showing_play_page and OnlineRelay.room.is_empty():
		_show_play_page()
		return
	if showing_play_page and not OnlineRelay.room.is_empty() and not bool(OnlineRelay.room.get("match_started", false)):
		online_waiting_to_start = false
		_show_setup_page()
		return
	if not showing_play_page:
		if online_waiting_to_start and OnlineRelay.player_id not in (OnlineRelay.room.get("ready_player_ids", []) as Array): online_waiting_to_start = false
		_update_selection_state()


func _on_online_initiative_changed(_result: Dictionary) -> void:
	_refresh_online_buttons()
	if not showing_play_page: _update_selection_state()


func _on_online_battle_ready(_match: Dictionary) -> void:
	if showing_play_page or not online_waiting_to_start: return
	online_waiting_to_start = false
	_begin_session()


func _initiative_status_text() -> String:
	var first_player := String(OnlineRelay.room.get("first_player_id", ""))
	if first_player.is_empty(): return _tr_ui("initiative_needed")
	return _tr_ui("initiative_you_first") if first_player == OnlineRelay.player_id else _tr_ui("initiative_opponent_first")


func _refresh_online_buttons() -> void:
	for button in online_status_buttons:
		if is_instance_valid(button): button.text = _online_button_text()


func _on_online_connection_changed(_state: StringName) -> void:
	_refresh_online_buttons()


func _show_popup_at_size(popup: PopupPanel, requested_size: Vector2i) -> void:
	var viewport_size := Vector2i(get_viewport_rect().size)
	var available_width := maxi(280, viewport_size.x - 24)
	var available_height := maxi(220, viewport_size.y - 24)
	var target_size := Vector2i(
		mini(requested_size.x, available_width),
		mini(requested_size.y, available_height)
	)
	# Embedded PopupPanels can restore their previous full-height rect during the
	# following layout pass. Lock both bounds and enforce the rect again after
	# Godot has completed that pass.
	popup.min_size = target_size
	popup.max_size = target_size
	popup.popup_centered(target_size)
	_lock_popup_rect.call_deferred(popup, target_size)


func _lock_popup_rect(popup: PopupPanel, target_size: Vector2i) -> void:
	if not is_instance_valid(popup): return
	var viewport_size := Vector2i(get_viewport_rect().size)
	popup.size = target_size
	popup.position = Vector2i(
		maxi(0, int((viewport_size.x - target_size.x) / 2.0)),
		maxi(0, int((viewport_size.y - target_size.y) / 2.0))
	)
	await get_tree().process_frame
	if not is_instance_valid(popup): return
	popup.size = target_size
	popup.position = Vector2i(
		maxi(0, int((viewport_size.x - target_size.x) / 2.0)),
		maxi(0, int((viewport_size.y - target_size.y) / 2.0))
	)
func _confirm_opponent_turn_finished() -> void:
	if phase != "opponent": return
	pending_opponent_reminders.clear()
	phase = "player"
	turn_number += 1
	_show_play_page()

func _adjust_hp(delta: int) -> void:
	var max_hp := int(selected_pokemon.get("max_hp",0))
	current_hp = clampi(current_hp + delta, 0, max_hp)
	_update_phase_ui()

func _extract_timed_reminders(move_id: String, move_doc: Dictionary, target_phase: String) -> Array[Dictionary]:
	var result: Array[Dictionary] = []
	var outcomes := _move_outcome_rules(move_doc)
	for i in outcomes.size():
		var outcome: Dictionary = outcomes[i] as Dictionary; var raw := String(outcome.get("raw_text","")).to_lower()
		var is_opponent := _effect_targets_opponent_next_turn(raw)
		var is_self := _effect_targets_self_next_turn(raw)
		if (target_phase == "opponent" and not is_opponent) or (target_phase == "self" and not is_self): continue
		var condition: Dictionary = outcome.get("condition",{}) as Dictionary
		result.append({"text":_localized_outcome_text(move_id,move_doc,i,outcome),"orientations":condition.get("orientations",[])})
	return result

func _has_timed_effect(move_doc: Dictionary) -> bool:
	for raw in _move_outcome_rules(move_doc):
		var text := String((raw as Dictionary).get("raw_text","")).to_lower()
		if "next turn" in text and not "last turn" in text: return true
	return false

func _localized_outcome_text(move_id: String, move_doc: Dictionary, index: int, outcome: Dictionary) -> String:
	var raw_text := String(outcome.get("raw_text", ""))
	var card_key := "move_card.%s.effect_%d" % [move_id, index]
	var move_key := "move.%s.effect_%d" % [String(move_doc.get("move_name_id", "")), index]
	var localized := raw_text
	if locale_entries.has(card_key): localized = String(locale_entries[card_key])
	elif locale_entries.has(move_key): localized = String(locale_entries[move_key])
	elif fallback_entries.has(card_key): localized = String(fallback_entries[card_key])
	elif fallback_entries.has(move_key): localized = String(fallback_entries[move_key])
	return _localize_orientation_tokens(localized)

func _localize_orientation_tokens(value: String) -> String:
	var result := value
	for orientation in ["HEAD_UP","HEAD_DOWN","HEAD_LEFT","HEAD_RIGHT","FACE_UP","FACE_DOWN"]:
		result = result.replace(orientation, _orientation_display_name(orientation))
	return result

func _orientation_suffix(reminder: Dictionary) -> String:
	var values: Array = reminder.get("orientations",[]) as Array
	if values.is_empty(): return ""
	var text := PackedStringArray(); for item in values: text.append(_orientation_display_name(String(item)))
	return "  [%s]" % ", ".join(text)

func _energy_icon(type_id: String, size: int) -> TextureRect:
	var icon := TextureRect.new(); icon.custom_minimum_size = Vector2(size,size); icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE; icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED; icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	icon.texture = _energy_texture(type_id)
	icon.tooltip_text = _type_name(type_id); return icon

func _energy_texture(type_id: String) -> Texture2D:
	var path := "%s/%s.webp" % [ENERGY_ICON_DIR,type_id]
	if ResourceLoader.exists(path): return load(path) as Texture2D
	return null

func _add_energy_cost_icons(row: HBoxContainer, move_doc: Dictionary, size: int) -> void:
	var costs: Array = move_doc.get("energy_cost",[]) as Array
	if costs.is_empty():
		var none := Label.new(); none.text = _tr_ui("no_energy"); none.mouse_filter = Control.MOUSE_FILTER_IGNORE; row.add_child(none); return
	for raw in costs:
		var cost: Dictionary = raw as Dictionary; var type_id := String(cost.get("energy_type","")); var count := int(cost.get("count",0))
		for i in count: row.add_child(_energy_icon(type_id,size))

func _kyokoro_texture(orientation: String) -> Texture2D:
	var file_name := orientation.to_lower() + ".webp"
	var path := KYOKORO_ICON_DIR.path_join(file_name)
	if ResourceLoader.exists(path):
		return load(path) as Texture2D
	return null


func _kyokoro_button_texture(orientation: String, size: int) -> Texture2D:
	var source := _kyokoro_texture(orientation)
	if source == null: return null
	var image := source.get_image()
	if image == null or image.is_empty(): return source
	image.resize(size, size, Image.INTERPOLATE_LANCZOS)
	return ImageTexture.create_from_image(image)


func _kyokoro_icon(orientation: String, size: int) -> TextureRect:
	var icon := TextureRect.new()
	icon.custom_minimum_size = Vector2(size,size)
	icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	icon.mouse_filter = Control.MOUSE_FILTER_IGNORE
	icon.texture = _kyokoro_texture(orientation)
	icon.tooltip_text = _orientation_display_name(orientation)
	return icon


func _orientation_display_name(orientation: String) -> String:
	match orientation:
		"HEAD_UP": return _tr_ui("head_up")
		"HEAD_DOWN": return _tr_ui("head_down")
		"HEAD_LEFT": return _tr_ui("head_left")
		"HEAD_RIGHT": return _tr_ui("head_right")
		"FACE_UP": return _tr_ui("face_up")
		"FACE_DOWN": return _tr_ui("face_down")
		_: return orientation.replace("_"," ").capitalize()


func _attack_type_card_color(type_id: String) -> Color:
	match type_id:
		"grass": return Color("52b96f")
		"fire": return Color("e75b4f")
		"water": return Color("4c9fd8")
		"electric": return Color("f2c84a")
		"psychic": return Color("d767ad")
		"fighting": return Color("df8742")
		"dark": return Color("397983")
		"steel": return Color("8995aa")
		"flying": return Color("62b9cf")
		_: return Color("a8a8a8")


func _transparent_card_button_style(border_color: Color, border_width: int) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.01,0.015,0.02,0.01)
	style.border_color = border_color
	style.set_border_width_all(border_width)
	style.set_corner_radius_all(8)
	return style


func _add_card_label(parent: Control, value: String, anchors: Vector4, font_size: int, alignment: HorizontalAlignment, color: Color, outline_size: int = 1, outline_color: Color = Color(0.02,0.03,0.05,0.95)) -> Label:
	var label := Label.new()
	label.text = value
	label.horizontal_alignment = alignment
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	label.add_theme_font_size_override("font_size",font_size)
	label.add_theme_color_override("font_color",color)
	label.add_theme_color_override("font_outline_color",outline_color)
	label.add_theme_constant_override("outline_size",outline_size)
	label.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
	_set_fractional_rect(label,anchors)
	parent.add_child(label)
	return label


func _set_fractional_rect(control: Control, anchors: Vector4) -> void:
	control.anchor_left = anchors.x
	control.anchor_top = anchors.y
	control.anchor_right = anchors.z
	control.anchor_bottom = anchors.w
	control.offset_left = 0.0
	control.offset_top = 0.0
	control.offset_right = 0.0
	control.offset_bottom = 0.0


func _effect_targets_opponent_next_turn(raw: String) -> bool:
	return ("opponent's next turn" in raw or "opponent’s next turn" in raw or "during your opponent's next turn" in raw or ("opponent cannot" in raw and "their next turn" in raw)) and not "last turn" in raw


func _effect_targets_self_next_turn(raw: String) -> bool:
	return "your next turn" in raw or "next turn, you" in raw


func _ui_button_style(bg_color: Color, border_color: Color, border_width: int) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = bg_color
	style.border_color = border_color
	style.set_border_width_all(border_width)
	style.set_corner_radius_all(7)
	style.content_margin_left = 12.0
	style.content_margin_right = 12.0
	style.content_margin_top = 8.0
	style.content_margin_bottom = 8.0
	return style

func _configure_touch_scrollbar(scroll: ScrollContainer) -> void:
	scroll.vertical_scroll_mode = ScrollContainer.SCROLL_MODE_AUTO
	var bar := scroll.get_v_scroll_bar()
	bar.custom_minimum_size.x = 30.0
	bar.add_theme_stylebox_override("scroll", _scrollbar_style(Color(0.06,0.10,0.14,0.10), Color(0.20,0.28,0.36,0.14), 1))
	bar.add_theme_stylebox_override("grabber", _scrollbar_style(Color("66819b"), Color("91abc4"), 1))
	bar.add_theme_stylebox_override("grabber_highlight", _scrollbar_style(Color("8fb3d4"), Color("c4e1fb"), 2))
	bar.add_theme_stylebox_override("grabber_pressed", _scrollbar_style(Color("b3d7f5"), Color.WHITE, 2))

func _scrollbar_style(color: Color, border_color: Color, border_width: int) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = color
	style.border_color = border_color
	style.set_border_width_all(border_width)
	style.set_corner_radius_all(10)
	style.content_margin_left = 4.0
	style.content_margin_right = 4.0
	return style


func _panel_style(color: Color, radius: int, border_color: Color, border_width: int) -> StyleBoxFlat:
	var style := StyleBoxFlat.new(); style.bg_color = color; style.border_color = border_color; style.set_border_width_all(border_width); style.corner_radius_top_left = radius; style.corner_radius_top_right = radius; style.corner_radius_bottom_left = radius; style.corner_radius_bottom_right = radius; return style

func _type_name(type_id: String) -> String:
	return _tr_content("type.%s.name" % type_id,type_id.capitalize())

func _energy_cost_text(move_doc: Dictionary) -> String:
	var costs: Array = move_doc.get("energy_cost",[]) as Array
	if costs.is_empty(): return "Enekoro —"
	var parts := PackedStringArray()
	for raw in costs:
		var cost: Dictionary = raw as Dictionary; var type_id := String(cost.get("energy_type","")); parts.append("%s ×%d" % [_type_name(type_id),int(cost.get("count",0))])
	return "Enekoro " + " + ".join(parts)

func _damage_text(move_doc: Dictionary) -> String:
	var damage = move_doc.get("printed_damage",null); return _tr_ui("damage", {"value":_format_damage_value(damage)})

func _format_damage_value(damage: Variant) -> String:
	if damage == null:
		return "—"
	return str(int(round(float(damage))))

func _first_line(text: String, max_chars: int) -> String:
	var line := text.replace("\n"," ").strip_edges(); return line if line.length() <= max_chars else line.left(max_chars-1) + "…"
