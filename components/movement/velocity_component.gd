class_name VelocityComponent
extends Node2D

const Y_VELOCITY_LIMITS := Vector2(-500, 350)

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


func stop_velocity() -> void:
	body.velocity = Vector2.ZERO


func get_velocity() -> Vector2:
	return Vector2(body.velocity)


func is_on_floor() -> bool:
	return body.is_on_floor()


func apply_gravity(delta: float) -> void:
	if not affected_by_gravity:
		return

	if not body.is_on_floor():
		var y_delta: float = (delta * body.get_gravity()).y
		body.velocity.y = clamp(body.velocity.y + y_delta, Y_VELOCITY_LIMITS.x, Y_VELOCITY_LIMITS.y)

	is_falling = body.velocity.y >= 0 and not body.is_on_floor()


func move() -> void:
	body.move_and_slide()
