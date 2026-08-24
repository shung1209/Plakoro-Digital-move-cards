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

const LOCALES := {
	"English": "en_US",
	"Español": "es_ES",
	"日本語": "ja_JP",
	"繁體中文": "zh_TW"
}

const UI_TEXT := {
	"en_US": {
		"title": "PLAKORO — Digital Move Cards", "setup_subtitle": "Choose one Pokémon and exactly four move cards for your physical tabletop game.", "pokemon": "Pokémon", "move_cards": "Move cards", "start_session": "Start Tabletop Session", "selected_count": "{current} / {max} selected", "used_cards": "Used cards: {cards}", "hide_info": "Hide info ▲", "show_info": "Show info ▼", "info_tooltip": "Hide or show the optional Pokémon / HP / weakness information.", "your_turn_short": "Turn {turn}  •  YOUR TURN", "opponent_turn_short": "Turn {turn}  •  OPPONENT TURN", "end_game": "End Game", "reduce_hp": "Reduce HP by 10", "restore_hp": "Restore HP by 10", "weakness": "Weakness:", "weakness_tooltip": "{type} weakness", "your_turn": "Turn {turn} — YOUR TURN: choose one move", "opponent_turn": "Turn {turn} — OPPONENT TURN: resolve the physical turn, then confirm when finished", "last_charakoro": "Last Charakoro: {result}", "roll_failed_ignored": "Enekoro insufficient — move failed; Charakoro effect ignored", "triggered": "Triggered: {effects}", "active_effect": "⚠ Active turn effect", "waiting_opponent": "WAITING FOR OPPONENT", "locked_last_turn": "LOCKED — used last turn", "locked_tooltip": "This move was used last turn and cannot be used this turn.", "opponent_instructions": "Resolve the opponent's turn on the physical table. Adjust HP with −10 / +10 above if needed.", "opponent_finished": "Opponent Turn Finished", "roll_hint": "Roll Enekoro and Charakoro together on the physical table. The Enekoro requirement is validated first; only a successful move may trigger its Charakoro effect.", "cancel": "Cancel", "use_move": "Use Move", "resolve_roll": "Resolve Enekoro + Charakoro", "resolve_subtitle": "Enekoro is checked first. If it succeeds, select the Charakoro face from the same roll.", "enerkoro_failed": "Enekoro insufficient — move failed", "select_face": "Enekoro succeeded — select Charakoro face", "manual_resolution": "resolve manually if needed", "no_energy": "No Energy", "damage": "Damage {value}", "head_up": "Head Up", "head_down": "Head Down", "head_left": "Head Left", "head_right": "Head Right", "face_up": "Face Up", "face_down": "Face Down"
	},
	"es_ES": {
		"title": "PLAKORO — Cartas digitales de movimientos", "setup_subtitle": "Elige un Pokémon y exactamente cuatro cartas de movimiento para tu partida física.", "pokemon": "Pokémon", "move_cards": "Cartas de movimiento", "start_session": "Iniciar sesión de mesa", "selected_count": "{current} / {max} seleccionadas", "used_cards": "Cartas usadas: {cards}", "hide_info": "Ocultar información ▲", "show_info": "Mostrar información ▼", "info_tooltip": "Oculta o muestra la información opcional de Pokémon, PS y debilidad.", "your_turn_short": "Turno {turn}  •  TU TURNO", "opponent_turn_short": "Turno {turn}  •  TURNO DEL OPONENTE", "end_game": "Finalizar partida", "reduce_hp": "Reducir PS en 10", "restore_hp": "Recuperar 10 PS", "weakness": "Debilidad:", "weakness_tooltip": "Debilidad a {type}", "your_turn": "Turno {turn} — TU TURNO: elige un movimiento", "opponent_turn": "Turno {turn} — TURNO DEL OPONENTE: resuelve el turno físico y confirma al terminar", "last_charakoro": "Último Charakoro: {result}", "roll_failed_ignored": "Enekoro insuficiente — el movimiento falló; se ignora el efecto Charakoro", "triggered": "Activado: {effects}", "active_effect": "⚠ Efecto de turno activo", "waiting_opponent": "ESPERANDO AL OPONENTE", "locked_last_turn": "BLOQUEADO — usado el turno anterior", "locked_tooltip": "Este movimiento se usó el turno anterior y no puede usarse este turno.", "opponent_instructions": "Resuelve el turno del oponente en la mesa. Ajusta los PS con −10 / +10 arriba si es necesario.", "opponent_finished": "Turno del oponente terminado", "roll_hint": "Lanza Enekoro y Charakoro juntos en la mesa. Primero se valida el requisito de Enekoro; solo un movimiento exitoso puede activar su efecto Charakoro.", "cancel": "Cancelar", "use_move": "Usar movimiento", "resolve_roll": "Resolver Enekoro + Charakoro", "resolve_subtitle": "Primero se comprueba Enekoro. Si tiene éxito, elige la cara de Charakoro de la misma tirada.", "enerkoro_failed": "Enekoro insuficiente — movimiento fallido", "select_face": "Enekoro exitoso — elige la cara de Charakoro", "manual_resolution": "resolver manualmente si es necesario", "no_energy": "Sin energía", "damage": "Daño {value}", "head_up": "Cabeza arriba", "head_down": "Cabeza abajo", "head_left": "Cabeza a la izquierda", "head_right": "Cabeza a la derecha", "face_up": "Cara arriba", "face_down": "Cara abajo"
	},
	"ja_JP": {
		"title": "PLAKORO — デジタルわざカード", "setup_subtitle": "ポケモンを1匹選び、実際の卓上ゲームで使うわざカードを4枚選んでください。", "pokemon": "ポケモン", "move_cards": "わざカード", "start_session": "テーブルセッションを開始", "selected_count": "{current} / {max} 枚選択済み", "used_cards": "使用したカード：{cards}", "hide_info": "情報を隠す ▲", "show_info": "情報を表示 ▼", "info_tooltip": "ポケモン・HP・弱点の補助情報を表示または非表示にします。", "your_turn_short": "ターン {turn}  •  あなたのターン", "opponent_turn_short": "ターン {turn}  •  相手のターン", "end_game": "ゲーム終了", "reduce_hp": "HPを10減らす", "restore_hp": "HPを10回復", "weakness": "弱点：", "weakness_tooltip": "{type}弱点", "your_turn": "ターン {turn} — あなたのターン：わざを1つ選択", "opponent_turn": "ターン {turn} — 相手のターン：実物の盤面で処理し、完了後に確認してください", "last_charakoro": "直前のチャラコロ：{result}", "roll_failed_ignored": "エネコロ不足 — わざ失敗；チャラコロ効果は無効", "triggered": "発動：{effects}", "active_effect": "⚠ 発動中のターン効果", "waiting_opponent": "相手のターンを待っています", "locked_last_turn": "使用不可 — 前のターンに使用済み", "locked_tooltip": "このわざは前のターンに使用したため、今のターンは使用できません。", "opponent_instructions": "実物の盤面で相手のターンを処理してください。必要なら上の −10 / +10 でHPを調整します。", "opponent_finished": "相手のターン完了", "roll_hint": "実物の盤面でエネコロとチャラコロを同時に振ります。最初にエネコロ条件を確認し、わざが成功した場合のみチャラコロ効果を発動できます。", "cancel": "キャンセル", "use_move": "わざを使う", "resolve_roll": "エネコロ＋チャラコロ判定", "resolve_subtitle": "最初にエネコロを確認します。成功したら、同じ出目のチャラコロ面を選択してください。", "enerkoro_failed": "エネコロ不足 — わざ失敗", "select_face": "エネコロ成功 — チャラコロ面を選択", "manual_resolution": "必要に応じて手動で処理", "no_energy": "エネルギーなし", "damage": "ダメージ {value}", "head_up": "頭が上", "head_down": "頭が下", "head_left": "頭が左", "head_right": "頭が右", "face_up": "顔が上", "face_down": "顔が下"
	},
	"zh_TW": {
		"title": "PLAKORO — 數位招式卡", "setup_subtitle": "選擇一隻 Pokémon 與四張招式卡，在實體桌遊中使用。", "pokemon": "Pokémon", "move_cards": "招式卡", "start_session": "開始桌遊輔助", "selected_count": "已選 {current} / {max} 張", "used_cards": "已使用的卡片：{cards}", "hide_info": "隱藏資訊 ▲", "show_info": "顯示資訊 ▼", "info_tooltip": "顯示或隱藏 Pokémon、HP 與弱點等輔助資訊。", "your_turn_short": "第 {turn} 回合  •  你的回合", "opponent_turn_short": "第 {turn} 回合  •  對手回合", "end_game": "結束遊戲", "reduce_hp": "HP 減少 10", "restore_hp": "HP 回復 10", "weakness": "弱點：", "weakness_tooltip": "弱點：{type}", "your_turn": "第 {turn} 回合 — 你的回合：選擇一個招式", "opponent_turn": "第 {turn} 回合 — 對手回合：在實體桌面完成操作後確認結束", "last_charakoro": "上次 Charakoro：{result}", "roll_failed_ignored": "Enekoro 不足 — 招式失敗；忽略 Charakoro 效果", "triggered": "已觸發：{effects}", "active_effect": "⚠ 生效中的回合效果", "waiting_opponent": "等待對手回合", "locked_last_turn": "無法使用 — 上回合已使用", "locked_tooltip": "此招式上回合已使用，本回合無法再次使用。", "opponent_instructions": "請在實體桌面完成對手回合；如有需要，可使用上方 −10 / +10 調整 HP。", "opponent_finished": "對手回合結束", "roll_hint": "請在實體桌面同時擲出 Enekoro 與 Charakoro。先確認 Enekoro 是否符合需求；招式成功後才能觸發 Charakoro 效果。", "cancel": "取消", "use_move": "使用招式", "resolve_roll": "判定 Enekoro + Charakoro", "resolve_subtitle": "先確認 Enekoro；若成功，請選擇同一次擲骰的 Charakoro 骰面。", "enerkoro_failed": "Enekoro 不足 — 招式失敗", "select_face": "Enekoro 成功 — 選擇 Charakoro 骰面", "manual_resolution": "如有需要請手動處理", "no_energy": "不需能量", "damage": "傷害 {value}", "head_up": "頭部朝上", "head_down": "頭部朝下", "head_left": "頭部朝左", "head_right": "頭部朝右", "face_up": "正面朝上", "face_down": "正面朝下"
	}
}

const TYPE_COLORS := {
	"fire": Color("7f3027"), "water": Color("255678"), "electric": Color("8b7620"),
	"grass": Color("376c3d"), "flying": Color("546c86"), "normal": Color("62656c"),
	"psychic": Color("783b6c"), "fighting": Color("7d4932"), "steel": Color("52676c"),
	"dark": Color("3f3a49")
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
var usage_history: Array[String] = []
var last_kyokoro_result := ""
var last_resolved_effects: Array[String] = []

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
var history_label: Label
var hp_label: Label
var phase_label: Label
var reminder_box: VBoxContainer
var play_moves_grid: GridContainer
var opponent_panel: PanelContainer
var app_theme: Theme
var status_details_expanded := false
var showing_play_page := false
var last_layout_signature := ""
var layout_refresh_pending := false

func _ready() -> void:
	_load_database()
	_load_locale("en_US")
	_build_shell()
	_show_setup_page()
	get_viewport().size_changed.connect(_on_viewport_size_changed)

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
	var value := String(locale_table.get(key, (UI_TEXT["en_US"] as Dictionary).get(key, key)))
	for replacement_key in replacements.keys():
		value = value.replace("{%s}" % String(replacement_key), str(replacements[replacement_key]))
	return value

func _pokemon_name(doc: Dictionary) -> String:
	return _tr_content("pokemon.%s.name" % String(doc.get("species_id", "")), String(doc.get("display_name", "")))

func _move_name(doc: Dictionary) -> String:
	return _tr_content("move.%s.name" % String(doc.get("move_name_id", "")), String(doc.get("display_name", "")))

func _move_description(doc: Dictionary) -> String:
	var card_id := String(doc.get("id", ""))
	var card_text := _tr_content("move_card.%s.description" % card_id, "")
	if not card_text.is_empty(): return _localize_orientation_tokens(card_text)
	var source: Dictionary = doc.get("source", {}) as Dictionary
	return _localize_orientation_tokens(_tr_content("move.%s.description" % String(doc.get("move_name_id", "")), String(source.get("raw_text", ""))))

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
	page_padding.add_theme_constant_override("margin_right",14)
	viewport_scroll.add_child(page_padding)
	page = VBoxContainer.new()
	page.name = "Page"
	page.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	page.size_flags_vertical = Control.SIZE_EXPAND_FILL
	page.custom_minimum_size.y = maxf(0.0, get_viewport_rect().size.y - 28.0)
	page.add_theme_constant_override("separation", 14)
	page_padding.add_child(page)

func _clear_page() -> void:
	for child in page.get_children():
		page.remove_child(child)
		child.queue_free()
	# Dynamic UI references must not point at nodes queued for deletion when the
	# compact status panel is collapsed.
	hp_label = null
	phase_label = null
	reminder_box = null
	opponent_panel = null
	history_label = null

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
	pokemon_name_label = Label.new(); pokemon_name_label.add_theme_font_size_override("font_size",24); left.add_child(pokemon_name_label)
	pokemon_meta_row = HBoxContainer.new(); pokemon_meta_row.add_theme_constant_override("separation", 10); left.add_child(pokemon_meta_row)
	pokemon_meta_label = Label.new()
	pokemon_meta_label.autowrap_mode = TextServer.AUTOWRAP_OFF
	pokemon_meta_label.custom_minimum_size = Vector2(105,30)
	pokemon_meta_label.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
	pokemon_meta_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	pokemon_meta_row.add_child(pokemon_meta_label)
	pokemon_type_icon = TextureRect.new(); pokemon_type_icon.custom_minimum_size = Vector2(30,30); pokemon_type_icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE; pokemon_type_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED; pokemon_type_icon.mouse_filter = Control.MOUSE_FILTER_IGNORE; pokemon_meta_row.add_child(pokemon_type_icon)
	pokemon_weakness_row = HBoxContainer.new(); pokemon_weakness_row.add_theme_constant_override("separation",8); left.add_child(pokemon_weakness_row)
	var right := VBoxContainer.new(); right.size_flags_horizontal = Control.SIZE_EXPAND_FILL; right.size_flags_vertical = Control.SIZE_EXPAND_FILL; right.add_theme_constant_override("separation",10); body.add_child(right)
	var move_header := HBoxContainer.new(); right.add_child(move_header)
	var move_title := Label.new(); move_title.text = _tr_ui("move_cards"); move_title.add_theme_font_size_override("font_size",20); move_title.size_flags_horizontal = Control.SIZE_EXPAND_FILL; move_header.add_child(move_title)
	selection_count_label = Label.new(); move_header.add_child(selection_count_label)
	var scroll := ScrollContainer.new(); scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL; scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL; scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED; _configure_touch_scrollbar(scroll); right.add_child(scroll)
	var scroll_content_margin := MarginContainer.new(); scroll_content_margin.size_flags_horizontal = Control.SIZE_EXPAND_FILL; scroll_content_margin.add_theme_constant_override("margin_right",12); scroll.add_child(scroll_content_margin)
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
				(move_checkboxes[move_id] as CheckButton).set_pressed_no_signal(true)
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
	selected_pokemon = doc; selected_move_ids.clear(); move_checkboxes.clear()
	pokemon_name_label.text = _pokemon_name(doc)
	pokemon_meta_label.text = "HP %d" % int(doc.get("max_hp", 0))
	var setup_type := String(doc.get("pokemon_type", ""))
	var setup_type_path := "%s/%s.webp" % [ENERGY_ICON_DIR, setup_type]
	pokemon_type_icon.texture = load(setup_type_path) if ResourceLoader.exists(setup_type_path) else null
	pokemon_type_icon.tooltip_text = _type_name(setup_type)
	var image_path := "res://assets/pokemon/images/%s.png" % String(doc.get("id","")); pokemon_preview.texture = load(image_path) if ResourceLoader.exists(image_path) else null
	_refresh_setup_weakness(doc)
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

func _rebuild_move_choices() -> void:
	for child in moves_grid.get_children(): moves_grid.remove_child(child); child.queue_free()
	move_checkboxes.clear()
	var ids: Array = selected_pokemon.get("available_move_card_ids",[]) as Array
	for raw_id in ids:
		var move_id := String(raw_id)
		if not move_docs.has(move_id): continue
		var move_doc: Dictionary = move_docs[move_id]
		var card := VBoxContainer.new(); card.custom_minimum_size = Vector2(330,128); card.size_flags_horizontal = Control.SIZE_EXPAND_FILL; card.add_theme_constant_override("separation",5); moves_grid.add_child(card)
		var check := CheckButton.new(); check.text = _move_name(move_doc); check.icon = _energy_texture(String(move_doc.get("attack_type","normal"))); check.expand_icon = true; check.icon_alignment = HORIZONTAL_ALIGNMENT_LEFT; check.add_theme_constant_override("icon_max_width",28); check.tooltip_text = _type_name(String(move_doc.get("attack_type","normal"))); check.add_theme_font_size_override("font_size",18); check.toggled.connect(_on_move_toggled.bind(move_id)); card.add_child(check); move_checkboxes[move_id] = check
		var summary_row := HBoxContainer.new(); summary_row.add_theme_constant_override("separation", 8); card.add_child(summary_row)
		_add_energy_cost_icons(summary_row, move_doc, 24)
		var damage_label := Label.new(); damage_label.text = "  •  %s" % _damage_text(move_doc); damage_label.modulate = Color(0.75,0.8,0.88); summary_row.add_child(damage_label)
		_add_setup_effect_summary(card, move_id, move_doc)
	_update_selection_state()

func _add_setup_effect_summary(card: VBoxContainer, move_id: String, move_doc: Dictionary) -> void:
	var outcomes: Array = move_doc.get("outcome_rules", []) as Array
	if outcomes.is_empty():
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
	if enabled:
		if selected_move_ids.size() >= MAX_MOVES:
			(move_checkboxes[move_id] as CheckButton).set_pressed_no_signal(false); return
		selected_move_ids.append(move_id)
	else: selected_move_ids.erase(move_id)
	_update_selection_state()

func _update_selection_state() -> void:
	if selection_count_label: selection_count_label.text = _tr_ui("selected_count", {"current":selected_move_ids.size(),"max":MAX_MOVES})
	if start_button: start_button.disabled = selected_move_ids.size() != MAX_MOVES

func _start_session() -> void:
	if selected_move_ids.size() != MAX_MOVES: return
	current_hp = int(selected_pokemon.get("max_hp",0)); previous_move_id = ""; turn_number = 1; phase = "player"
	pending_opponent_reminders.clear(); pending_self_reminders.clear(); usage_history.clear(); last_kyokoro_result = ""; last_resolved_effects.clear(); _show_play_page()

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
	_build_opponent_turn_panel()
	history_label = Label.new()
	history_label.text = _tr_ui("used_cards", {"cards":"—" if usage_history.is_empty() else "  →  ".join(PackedStringArray(usage_history))})
	history_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	history_label.modulate = Color("8fa0b4")
	page.add_child(history_label)
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
	end_game.pressed.connect(_show_setup_page)
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


func _toggle_status_details() -> void:
	status_details_expanded = not status_details_expanded
	_show_play_page()


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


func _build_real_move_card(move_id: String, move_doc: Dictionary, large: bool) -> Control:
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

	var attack_icon := _energy_icon(String(move_doc.get("attack_type","normal")), 70 if large else 42)
	_set_fractional_rect(attack_icon, Vector4(0.025,0.05,0.145,0.34))
	root.add_child(attack_icon)

	_add_card_label(root, _pokemon_name(selected_pokemon), Vector4(0.16,0.035,0.68,0.17), 18 if large else 11, HORIZONTAL_ALIGNMENT_LEFT, Color.WHITE, 2)
	_add_card_label(root, _move_name(move_doc), Vector4(0.14,0.15,0.80,0.43), 34 if large else 21, HORIZONTAL_ALIGNMENT_CENTER, Color.WHITE, 5 if large else 3)
	var damage_value := "—" if move_doc.get("printed_damage", null) == null else str(move_doc.get("printed_damage"))
	_add_card_label(root, damage_value, Vector4(0.80,0.13,0.97,0.43), 38 if large else 24, HORIZONTAL_ALIGNMENT_CENTER, Color(1.0,0.25,0.20), 5 if large else 3, Color.WHITE)
	_add_card_energy_icons(root, move_doc, large)
	_add_card_effect_rows(root, move_id, move_doc, large)

	var source: Dictionary = move_doc.get("source", {}) as Dictionary
	var card_code := String(source.get("card_code", "")).strip_edges()
	if not card_code.is_empty():
		_add_card_label(root, card_code, Vector4(0.76,0.87,0.96,0.98), 11 if large else 8, HORIZONTAL_ALIGNMENT_RIGHT, Color(0.84,0.87,0.92,0.92), 1)
	return root


func _add_card_energy_icons(parent: Control, move_doc: Dictionary, large: bool) -> void:
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
			costs.add_child(_energy_icon(String(cost.get("energy_type","normal")), 30 if large else 18))


func _add_card_effect_rows(parent: Control, move_id: String, move_doc: Dictionary, large: bool) -> void:
	var effects := VBoxContainer.new()
	effects.mouse_filter = Control.MOUSE_FILTER_IGNORE
	effects.add_theme_constant_override("separation", 6 if large else 3)
	_set_fractional_rect(effects, Vector4(0.025,0.49,0.965,0.93))
	parent.add_child(effects)
	var outcomes: Array = move_doc.get("outcome_rules",[]) as Array
	if outcomes.is_empty():
		var description := Label.new()
		description.mouse_filter = Control.MOUSE_FILTER_IGNORE
		description.text = _move_description(move_doc)
		description.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		description.max_lines_visible = 5
		description.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
		description.add_theme_font_size_override("font_size", 23 if large else 16)
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
				icons.add_child(_kyokoro_icon(String(raw_orientation), 32 if large else 20))

		var line := Label.new()
		line.mouse_filter = Control.MOUSE_FILTER_IGNORE
		line.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		line.text = _localized_outcome_text(move_id, move_doc, i, outcome)
		line.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		line.max_lines_visible = 4 if large else (3 if outcomes.size() <= 2 else 2)
		line.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
		line.add_theme_font_size_override("font_size", 22 if large else 15)
		line.add_theme_color_override("font_color", Color.WHITE)
		line.add_theme_color_override("font_outline_color", Color(0.02,0.03,0.05,0.95))
		line.add_theme_constant_override("outline_size", 2)
		row.add_child(line)

func _build_opponent_turn_panel() -> void:
	opponent_panel = PanelContainer.new(); opponent_panel.add_theme_stylebox_override("panel",_panel_style(Color("24272d"),10,Color("454952"),1)); page.add_child(opponent_panel)
	var margin := MarginContainer.new(); margin.add_theme_constant_override("margin_left",14); margin.add_theme_constant_override("margin_right",14); margin.add_theme_constant_override("margin_top",10); margin.add_theme_constant_override("margin_bottom",10); opponent_panel.add_child(margin)
	var row := HBoxContainer.new(); row.add_theme_constant_override("separation",12); margin.add_child(row)
	var label := Label.new(); label.text = _tr_ui("opponent_instructions"); label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART; label.size_flags_horizontal = Control.SIZE_EXPAND_FILL; row.add_child(label)
	var confirm := Button.new(); confirm.text = _tr_ui("opponent_finished"); confirm.custom_minimum_size = Vector2(235,48); confirm.pressed.connect(_confirm_opponent_turn_finished); row.add_child(confirm)


func _update_phase_ui() -> void:
	if hp_label: hp_label.text = "HP %d / %d   •   %s" % [current_hp,int(selected_pokemon.get("max_hp",0)),_type_name(String(selected_pokemon.get("pokemon_type","")))]
	if phase_label:
		phase_label.text = _tr_ui("your_turn", {"turn":turn_number}) if phase == "player" else _tr_ui("opponent_turn", {"turn":turn_number})
	if opponent_panel: opponent_panel.visible = phase == "opponent"
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
	var content := VBoxContainer.new()
	content.add_theme_constant_override("separation",10)
	margin.add_child(content)
	var preview := _build_real_move_card(move_id, move_doc, true)
	preview.custom_minimum_size = Vector2(760,379)
	content.add_child(preview)
	var hint := Label.new()
	hint.text = _tr_ui("roll_hint")
	hint.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	hint.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	hint.modulate = Color(0.78,0.82,0.88)
	content.add_child(hint)
	var actions := HBoxContainer.new()
	actions.alignment = BoxContainer.ALIGNMENT_CENTER
	actions.add_theme_constant_override("separation",14)
	content.add_child(actions)
	var cancel_button := Button.new()
	cancel_button.text = _tr_ui("cancel")
	cancel_button.custom_minimum_size = Vector2(180,52)
	cancel_button.pressed.connect(popup.hide)
	actions.add_child(cancel_button)
	var use_button := Button.new()
	use_button.text = _tr_ui("use_move")
	use_button.custom_minimum_size = Vector2(180,52)
	use_button.pressed.connect(func(): popup.hide(); _confirm_use_move(move_id))
	actions.add_child(use_button)
	var viewport_size := get_viewport_rect().size
	var popup_width := int(minf(820.0,maxf(640.0,viewport_size.x-36.0)))
	var popup_height := int(minf(520.0,maxf(455.0,viewport_size.y-36.0)))
	popup.popup_centered(Vector2i(popup_width,popup_height))


func _confirm_use_move(move_id: String) -> void:
	if not move_docs.has(move_id) or phase != "player" or move_id == previous_move_id: return
	var move_doc: Dictionary = move_docs[move_id]
	var outcomes: Array = move_doc.get("outcome_rules",[]) as Array
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
		b.custom_minimum_size = Vector2(160, 54)
		b.text = _orientation_display_name(orientation)
		b.add_theme_font_size_override("font_size", 16)
		b.icon = _kyokoro_texture(orientation)
		b.expand_icon = true
		b.pressed.connect(_on_kyokoro_choice.bind(popup, move_id, move_doc, orientation))
		grid.add_child(b)

	var viewport_size := get_viewport_rect().size
	var popup_width := int(minf(590.0, maxf(500.0, viewport_size.x - 28.0)))
	var popup_height := int(minf(330.0, maxf(300.0, viewport_size.y - 28.0)))
	popup.popup_centered(Vector2i(popup_width, popup_height))

func _on_kyokoro_choice(popup: PopupPanel, move_id: String, move_doc: Dictionary, orientation: String) -> void:
	popup.hide()
	_resolve_kyokoro_and_finalize(move_id, move_doc, orientation)


func _resolve_kyokoro_and_finalize(move_id: String, move_doc: Dictionary, orientation: String) -> void:
	var matched: Array[Dictionary] = []
	var outcomes: Array = move_doc.get("outcome_rules",[]) as Array
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
	pending_self_reminders.clear()
	pending_opponent_reminders.clear()
	last_kyokoro_result = orientation
	last_resolved_effects.clear()
	for item in matched:
		var idx := int(item.get("index",0))
		var outcome: Dictionary = item.get("outcome",{}) as Dictionary
		var localized := _localized_outcome_text(move_id, move_doc, idx, outcome)
		last_resolved_effects.append("%s (%s)" % [localized, _tr_ui("manual_resolution")])
		var raw := String(outcome.get("raw_text","")).to_lower()
		var reminder := {"text":localized,"orientations":[orientation]}
		if _effect_targets_opponent_next_turn(raw): pending_opponent_reminders.append(reminder)
		if _effect_targets_self_next_turn(raw): pending_self_reminders.append(reminder)
	previous_move_id = move_id
	usage_history.push_front(_move_name(move_doc))
	if usage_history.size() > 8: usage_history.resize(8)
	phase = "opponent"
	_show_play_page()
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
	var outcomes: Array = move_doc.get("outcome_rules",[]) as Array
	for i in outcomes.size():
		var outcome: Dictionary = outcomes[i] as Dictionary; var raw := String(outcome.get("raw_text","")).to_lower()
		var is_opponent := _effect_targets_opponent_next_turn(raw)
		var is_self := _effect_targets_self_next_turn(raw)
		if (target_phase == "opponent" and not is_opponent) or (target_phase == "self" and not is_self): continue
		var condition: Dictionary = outcome.get("condition",{}) as Dictionary
		result.append({"text":_localized_outcome_text(move_id,move_doc,i,outcome),"orientations":condition.get("orientations",[])})
	return result

func _has_timed_effect(move_doc: Dictionary) -> bool:
	for raw in move_doc.get("outcome_rules",[]) as Array:
		var text := String((raw as Dictionary).get("raw_text","")).to_lower()
		if "next turn" in text and not "last turn" in text: return true
	return false

func _localized_outcome_text(move_id: String, move_doc: Dictionary, index: int, outcome: Dictionary) -> String:
	var raw_text := String(outcome.get("raw_text","")); var localized := _tr_content("move_card.%s.effect_%d" % [move_id,index],"")
	if localized.is_empty(): localized = _tr_content("move.%s.effect_%d" % [String(move_doc.get("move_name_id","")),index],raw_text)
	return _localize_orientation_tokens(localized)

func _localize_orientation_tokens(value: String) -> String:
	var result := value
	for orientation in ["HEAD_UP","HEAD_DOWN","HEAD_LEFT","HEAD_RIGHT","FACE_UP","FACE_DOWN"]:
		result = result.replace(orientation, _orientation_display_name(orientation))
	return result

func _orientation_suffix(reminder: Dictionary) -> String:
	var values: Array = reminder.get("orientations",[]) as Array
	if values.is_empty(): return ""
	var text := PackedStringArray(); for item in values: text.append(String(item))
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
	var bar := scroll.get_v_scroll_bar()
	bar.custom_minimum_size.x = 30.0
	bar.add_theme_stylebox_override("scroll", _scrollbar_style(Color("101923"), Color("25384b"), 1))
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
	var damage = move_doc.get("printed_damage",null); return _tr_ui("damage", {"value":"—" if damage == null else str(damage)})

func _first_line(text: String, max_chars: int) -> String:
	var line := text.replace("\n"," ").strip_edges(); return line if line.length() <= max_chars else line.left(max_chars-1) + "…"
