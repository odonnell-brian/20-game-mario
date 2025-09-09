class_name RayCastMoveComponent
extends Node2D
## Picks a movement direction based on the provided raycasts. Once a raycast condition isn't met, will reverse direction.

enum CollisionBehavior { MOVE, STOP }
enum Direction { LEFT = -1, RIGHT = 1}

@export_category("Dependencies")

@export_category("Settings")
@export var ray_casts: Dictionary[RayCast2D, CollisionBehavior]
@export var ray_pivot: Node2D
@export var wait_time: float = 2.0
@export var initial_direction: Direction = Direction.RIGHT

var next_direction: int
var direction: int = 0

@onready var wait_timer: Timer = $WaitTimer


func _ready() -> void:
	wait_timer.timeout.connect(on_wait_timeout)
	next_direction = -1
	orient_rays(next_direction)
	wait_timer.start(0.5)


func get_horizontal_movement_direction() -> float:
	return direction


func tick(_delta: float) -> void:
	var can_move: bool = true
	for ray in ray_casts.keys():
		can_move = can_move && can_move_for_ray(ray, ray_casts[ray])

	if not can_move and direction != 0:
		next_direction = direction * -1
		direction = 0
		wait_timer.start(wait_time)
		orient_rays(next_direction)


func on_wait_timeout() -> void:
	direction = next_direction


func can_move_for_ray(ray: RayCast2D, behavior: CollisionBehavior) -> bool:
	match behavior:
		CollisionBehavior.MOVE:
			return ray.is_colliding()
		CollisionBehavior.STOP:
			return not ray.is_colliding()

	return false


func orient_rays(dir: int) -> void:
	var multiplier: int = initial_direction * dir
	ray_pivot.scale.x = multiplier
