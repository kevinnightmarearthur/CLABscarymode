extends Node

var jumpscare_copy: Control

var jumpscare_index := -1

func _ready() -> void:
	get_tree().node_added.connect(_on_node_added)

	while not is_instance_valid(Globals.MAIN_NODE):
		await get_tree().process_frame
	await get_tree().process_frame

	get_tree().node_added.disconnect(_on_node_added)
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
