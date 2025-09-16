class_name Pipe
extends Node2D

@export_category("Dependencies")
@export var exit_marker: Marker2D
@export var enter_animation_end: Marker2D
@export var exit_animation_end: Marker2D

@export_category("Settings")
@export var input_action: String

var enabled: bool = true

@onready var interaction_area: Area2D = %InteractionArea


func _ready() -> void:
	interaction_area.body_exited.connect(on_body_exited)


func _unhandled_input(_event: InputEvent) -> void:
	if not enabled or not Input.is_action_just_pressed(input_action):
		return

	for body in interaction_area.get_overlapping_bodies():
		if body is Player:
			try_interact(body as Player)


func try_interact(player: Player) -> void:
	enabled = false
	player.set_input_enabled(false)

	var tween: Tween = create_tween()
	tween.tween_property(player, "global_position:x", enter_animation_end.global_position.x, 0.1)
	tween.parallel().tween_property(player, "global_position:y", enter_animation_end.global_position.y, 1.0)
	tween.tween_callback(func(): player.global_position = exit_marker.global_position)
	tween.tween_property(player, "global_position:y", exit_animation_end.global_position.y, 1.0)
	tween.tween_callback(func(): player.set_input_enabled(true))


func on_body_exited(body: Node2D) -> void:
	if body is Player:
		enabled = true
