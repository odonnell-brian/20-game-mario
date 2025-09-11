extends FxComponent

@export_category("Dependencies")
@export var node: Node2D

@export_category("Settings")
@export var offset: Vector2 = Vector2(0, -8.0)
@export var time_to_bounce_up: float = 0.2
@export var time_to_bounce_down: float = 0.15


func do_fx() -> void:
	var starting_position: Vector2 = node.global_position
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(node, "global_position", starting_position + offset, time_to_bounce_up).from_current()
	tween.tween_property(node, "global_position", starting_position, time_to_bounce_down).from_current()
	tween.tween_callback(effect_complete.emit)
