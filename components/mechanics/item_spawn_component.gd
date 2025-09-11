class_name ItemSpawnComponent
extends Area2D

signal item_spawn_started
signal item_spawn_complete

const TILE_SIZE_Y: float = 16.0

@export_category("Settings")
@export var item_to_spawn: PackedScene

var disabled: bool = false


func spawn_item() -> void:
	if disabled:
		return

	item_spawn_started.emit()

	disabled = true
	var item: Node2D = item_to_spawn.instantiate() as Node2D
	item.global_position = global_position - Vector2(0, (TILE_SIZE_Y / 4.0))
	get_tree().current_scene.add_child.call_deferred(item)

	var exclude: Array[Node] = [get_parent(), self, item]
	Globals.pause_scene_for_animation.emit.call_deferred(exclude)

	var original_process_mode = item.process_mode
	item.process_mode = Node.PROCESS_MODE_DISABLED

	var original_z_index =item.z_index
	item.z_index = z_index - 1

	var tween: Tween = create_tween()
	tween.tween_property(item, "global_position", global_position - Vector2(0, TILE_SIZE_Y), 0.20)
	tween.tween_callback(
		func():
			item.process_mode = original_process_mode
			item.z_index = original_z_index
	)
	tween.tween_callback(item_spawn_complete.emit)
	tween.tween_callback(Globals.unpause_scene_for_animation.emit.call_deferred)
