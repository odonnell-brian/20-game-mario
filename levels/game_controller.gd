extends Node2D

const ANIM_PAUSE_GROUP: String = "anim_pause"


func _ready() -> void:
	Globals.pause_scene_for_animation.connect(on_pause_for_animation)
	Globals.unpause_scene_for_animation.connect(on_unpause_for_animation)


func on_pause_for_animation(nodes_to_exclude: Array[Node]) -> void:
	for node in get_tree().get_nodes_in_group(ANIM_PAUSE_GROUP):
		node.process_mode = Node.PROCESS_MODE_DISABLED

	for node in nodes_to_exclude:
		node.process_mode = Node.PROCESS_MODE_ALWAYS


func on_unpause_for_animation() -> void:
	for node in get_tree().get_nodes_in_group(ANIM_PAUSE_GROUP):
		node.process_mode = Node.PROCESS_MODE_INHERIT
