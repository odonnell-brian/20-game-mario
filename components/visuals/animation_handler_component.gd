class_name AnimationHandlerComponent
extends Node2D

@export_category("Dependencies")
@export var animated_sprite: AnimatedSprite2D

var current_animation: String

func play_animation(anim_name: String) -> void:
	if current_animation != anim_name:
		current_animation = anim_name
		animated_sprite.play(current_animation)
