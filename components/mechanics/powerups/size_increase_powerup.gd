class_name SizeIncreasePowerup
extends Powerup

@export_category("Settings")
@export var end_scale: Vector2 = Vector2(1.25, 1.25)
@export var tween_time_seconds: float = 0.5

var scale_node: Node2D


func initiate(player: Player) -> void:
	scale_node = player

	for child in player.get_children():
		if child is HealthComponent:
			(child as HealthComponent).health_changed.connect(end_effect.unbind(1))


func on_pick_up() -> void:
	var tween: Tween = scale_node.create_tween()
	tween.tween_property(scale_node, "scale", end_scale, tween_time_seconds).from_current()


func end_effect() -> void:
	pass


func apply_effect() -> void:
	scale_node.scale = end_scale
