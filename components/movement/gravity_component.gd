class_name GravityComponent
extends Node2D

@export_category("Dependencies")
@export var body: CharacterBody2D
@export var velocity_component: VelocityComponent

@export_subgroup("Settings")
@export var gravity: float = 20.0

var is_falling: bool = false

func _physics_process(_delta: float) -> void:
	if not body.is_on_floor():
		velocity_component.velocity.y += gravity

	is_falling = velocity_component.velocity.y > 0 and not body.is_on_floor()
