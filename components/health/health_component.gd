class_name HealthComponent
extends Area2D

@warning_ignore("unused_signal")
signal destroy_fx_complete

signal health_changed(current_health: int)
signal health_depleted

@export_category("Settings")
@export var max_health: int = 1
@export var destroy_on_deplete: bool = true

@export_category("OptionalDependencies")
@export var destroy_fx: FxComponent
@export var invuln_timer: Timer
@export var hit_fx: FxComponent

var current_health: int
var is_invulnerable: bool = false


func _ready() -> void:
	current_health = max_health

	if invuln_timer:
		invuln_timer.timeout.connect(on_invulnerability_timeout)


func try_damage(amount: int) -> void:
	if is_invulnerable:
		return

	take_damage(amount)


func take_damage(amount: int) -> void:
	handle_invulnerability()

	current_health = maxi(current_health - amount, 0)
	health_changed.emit(current_health)

	if current_health == 0:
		health_depleted.emit()
		try_destroy()
	elif hit_fx:
		hit_fx.do_fx()


func handle_invulnerability() -> void:
	if not invuln_timer:
		return

	is_invulnerable = true
	invuln_timer.start()


func try_destroy() -> void:
	if destroy_fx:
		destroy_fx.effect_complete.connect(destroy_fx_complete.emit)
		destroy_fx.do_fx()

	if destroy_on_deplete:
		get_parent().queue_free()


func on_invulnerability_timeout() -> void:
	is_invulnerable = false
