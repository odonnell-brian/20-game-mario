class_name StompComponent
extends Area2D

signal stomped()

@export_category("Settings")
@export var damage: int = 1

func _ready() -> void:
	area_entered.connect(on_area_entered)

func on_area_entered(area: Area2D) -> void:
	if not area is StompableComponent:
		return

	(area as StompableComponent).do_stomp(damage)
	stomped.emit()
