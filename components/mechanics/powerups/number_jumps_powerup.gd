class_name NumberJumpsPowerup
extends Powerup

@export_category("Settings")
@export var max_jumps: int = 2

var jump_component: JumpComponent


func initiate(player: Player) -> void:
	for child in player.get_children():
		if child is JumpComponent:
			jump_component = child as JumpComponent


func on_pick_up() -> void:
	apply_effect()


func end_effect() -> void:
	jump_component.reset_max_jumps()
	powerup_complete.emit()


func apply_effect() -> void:
	jump_component.update_max_jumps(max_jumps)
