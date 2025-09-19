class_name PowerupManagerComponent
extends Area2D

@export_category("Dependencies")
@export var player: Player

var current_powerup: Powerup


func try_apply_powerup(powerup: Powerup) -> bool:
	if current_powerup == powerup:
		return false

	change_current_powerup(powerup)

	current_powerup.initiate(player)
	current_powerup.on_pick_up()

	return true


func change_current_powerup(new_powerup: Powerup) -> void:
	if current_powerup:
		current_powerup.powerup_complete.disconnect(on_powerup_complete)

	current_powerup = new_powerup

	if current_powerup:
		current_powerup.powerup_complete.connect(on_powerup_complete)


func on_powerup_complete() -> void:
	change_current_powerup(null)
