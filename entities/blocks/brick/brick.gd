extends StaticBody2D

@export_category("Dependencies")
@export var health_component: HealthComponent
@export var sprite_normal: Sprite2D
@export var sprite_cracked: Sprite2D


func _ready() -> void:
	health_component.health_changed.connect(on_health_changed)


func on_health_changed(current_health: int) -> void:
	if current_health > 0:
		sprite_normal.visible = false
		sprite_cracked.visible = true
