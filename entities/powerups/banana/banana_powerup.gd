class_name BananaPowerup
extends Area2D


func _ready() -> void:
	area_entered.connect(on_area_entered)


func on_area_entered(area: Area2D) -> void:
	if not area is BananaPower:
		return

	(area as BananaPower).activate()
	queue_free.call_deferred()
