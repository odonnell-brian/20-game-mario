class_name StompableComponent
extends Area2D

@export_category("Dependencies")
@export var health_component: HealthComponent

func do_stomp(damage: int) -> void:
	health_component.try_damage(damage)
