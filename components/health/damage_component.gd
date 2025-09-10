class_name DamageComponent
extends Area2D

@export_category("Settings")
@export var damage_amount: int = 1
@export var cooldown_time: float = -1

@onready var cooldown_timer: Timer = $Timer


func _ready() -> void:
	area_entered.connect(try_damage)
	start_cooldown()


func try_damage(node: Node2D) -> void:
	if not node is HealthComponent or not cooldown_timer.is_stopped():
		return

	if node.get_parent() == get_parent():
		print("damaging self %s" % [get_parent().name])

	(node as HealthComponent).try_damage(damage_amount)
	start_cooldown()


func start_cooldown() -> void:
	if cooldown_time > 0:
		cooldown_timer.start(cooldown_time)
