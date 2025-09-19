class_name PowerupProviderComponent
extends Area2D

@export_category("Settings")
@export var powerup: Powerup


func _ready() -> void:
	area_entered.connect(on_area_entered)


func on_area_entered(area: Area2D) -> void:
	if area is PowerupManagerComponent:
		(area as PowerupManagerComponent).try_apply_powerup(powerup)
		get_parent().queue_free.call_deferred()
