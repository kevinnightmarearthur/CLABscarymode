extends Node

var jumpscare_on := true

var jumpscare_copy: Control

var jumpscare_index := -1

func _ready() -> void:
	get_tree().node_added.connect(_on_node_added)

	while not is_instance_valid(Globals.MAIN_NODE):
		await get_tree().process_frame
	await get_tree().process_frame

	Globals.SCARY_MODE_OPTION_AVAILABLE = true

	var ui = Globals.MAIN_NODE.get_node("UI")
	if not ui.has_node("JumpscareParent"):
		ui.add_child(jumpscare_copy)
		ui.move_child(jumpscare_copy, jumpscare_index)
	else:
		jumpscare_copy.free()

func _on_node_added(node: Node) -> void:
	if node.name == "JumpscareParent" and jumpscare_copy == null:
		jumpscare_copy = node.duplicate()
		jumpscare_index = node.get_index()
	elif node.name == "ScaryModeContainer":
		add_jumpscare_option.call_deferred(node)
	elif node is trigger_tutorial and node.tutorial_type == "END_GAME":
		node.get_node("%Area3D").body_entered.connect(_on_end_trigger_entered)
	elif not jumpscare_on and node.get_script() and node.get_script().resource_path.ends_with("scary_mode_stinger_player.gd"):
		node.time_left_in_scary_mode = INF

func add_jumpscare_option(scary_row: Control) -> void:
	if not is_instance_valid(scary_row) or scary_row.is_queued_for_deletion():
		return
	var menu = scary_row.owner
	var row: Control = scary_row.duplicate(DUPLICATE_GROUPS)
	row.name = "JumpscareContainer"
	var label: Label = row.get_child(0)
	label.text = "Jumpscare"
	var check: CheckBox = row.get_child(1)
	check.button_pressed = jumpscare_on
	check.toggled.connect(func(on): jumpscare_on = on)
	check.mouse_entered.connect(check.grab_focus)
	check.focus_entered.connect(func(): menu._belated_move.call_deferred(check.global_position.y))
	scary_row.add_sibling(row)

func _on_end_trigger_entered(_body: Node3D) -> void:
	if Globals.SCARY_MODE and Globals.MAIN_NODE.game_power >= 4.0:
		Globals.SCARY_MODE = false
		Globals.TUTORIAL_HUD.appear(Globals.TUTORIAL_HUD.TEXT_CONTENT_TYPE.END_GAME)
		Globals.SCARY_MODE = true
