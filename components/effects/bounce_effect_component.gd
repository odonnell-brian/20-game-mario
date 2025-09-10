extends FxComponent

@export_category("Dependencies")
@export var node: Node2D


func do_fx() -> void:
	var starting_position: Vector2 = node.global_position
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(node, "global_position", starting_position + Vector2(0, -8), 0.20).from_current()
	tween.tween_property(node, "global_position", starting_position, 0.15).from_current()
	tween.tween_callback(effect_complete.emit)
