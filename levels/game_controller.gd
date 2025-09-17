extends Node2D

const ANIM_PAUSE_GROUP: String = "anim_pause"

@export_category("Dependencies")
@export var camera: Camera2D

var camera_limits: Vector4


func _ready() -> void:
	Globals.pause_scene_for_animation.connect(on_pause_for_animation)
	Globals.unpause_scene_for_animation.connect(on_unpause_for_animation)
	Globals.update_camera_limits.connect(on_update_camera_limits)

	camera_limits = Vector4(camera.limit_left, camera.limit_right, camera.limit_top, camera.limit_bottom)


func on_pause_for_animation(nodes_to_exclude: Array[Node]) -> void:
	for node in get_tree().get_nodes_in_group(ANIM_PAUSE_GROUP):
		node.process_mode = Node.PROCESS_MODE_DISABLED

	for node in nodes_to_exclude:
		node.process_mode = Node.PROCESS_MODE_ALWAYS


func on_unpause_for_animation() -> void:
	for node in get_tree().get_nodes_in_group(ANIM_PAUSE_GROUP):
		node.process_mode = Node.PROCESS_MODE_INHERIT


func on_update_camera_limits(limits: Vector4i) -> void:
	camera.limit_left = limits.x
	camera.limit_right = limits.y
	camera.limit_top = limits.z
	camera.limit_bottom = limits.w
