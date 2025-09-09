class_name VelocityComponent
extends Node2D

@export_category("Dependencies")
@export var body: CharacterBody2D

@export_category("Settings")
@export var max_speed: float = 100
@export var affected_by_gravity: bool = true
@export var velocity_lerp_weight: float = 0.2

var is_falling: bool = false


func accelerate_horizontal_to_velocity(target_velocity: float) -> void:
	body.velocity.x = lerp(body.velocity.x, target_velocity, velocity_lerp_weight)


func accelerate_horizontal_in_direction(direction: float) -> void:
	accelerate_horizontal_to_velocity(direction * max_speed)


func decelerate_horizontal() -> void:
	accelerate_horizontal_to_velocity(0)


func apply_jump_force(amount: float) -> void:
	body.velocity.y = amount


func stop_vertical_velocity() -> void:
	body.velocity.y = 0


func get_velocity() -> Vector2:
	return Vector2(body.velocity)


func is_on_floor() -> bool:
	return body.is_on_floor()


func apply_gravity(delta: float) -> void:
	if not affected_by_gravity:
		return

	if not body.is_on_floor():
		body.velocity.y += (delta * body.get_gravity()).y

	is_falling = body.velocity.y >= 0 and not body.is_on_floor()


func move() -> void:
	body.move_and_slide()
