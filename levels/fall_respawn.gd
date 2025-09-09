extends Area2D

@onready var respawn_point: Marker2D = $Marker2D

func _ready() -> void:
	body_entered.connect(on_body_entered)


func on_body_entered(body: Node2D) -> void:
	body.global_position = respawn_point.global_position
