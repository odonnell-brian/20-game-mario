class_name VelocityComponent
extends Node2D

@export_category("Settings")
@export var max_speed: float = 100

var velocity: Vector2 = Vector2()

func accelerate_horizontal_to_velocity(target_velocity: float) -> void:
	velocity.x = lerp(velocity.x, target_velocity, 0.1)

func accelerate_horizontal_in_direction(direction: float) -> void:
	accelerate_horizontal_to_velocity(direction * max_speed)

func decelerate_horizontal() -> void:
	accelerate_horizontal_to_velocity(0)

func move(body: CharacterBody2D) -> void:
	body.velocity = velocity
	body.move_and_slide()
