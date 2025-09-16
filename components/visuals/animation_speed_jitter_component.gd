extends Node

@export_category("Dependencies")
@export var animated_sprite: AnimatedSprite2D

@export_category("Settings")
@export var speed_scale_range: Vector2


func _ready() -> void:
	animated_sprite.speed_scale = randf_range(speed_scale_range.x, speed_scale_range.y)
