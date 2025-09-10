class_name BananaPower
extends Area2D

@export_category("Dependencies")
@export var scale_node: Node2D


func activate() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(scale_node, "scale", Vector2(1.25, 1.25), 0.5).from_current()
