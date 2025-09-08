class_name JumpComponent
extends Node2D

@export_category("Dependencies")
@export var velocity_component: VelocityComponent

@export_subgroup("Settings")
@export var jump_velocity: float = -400.0
@export var jump_buffer_time: float = 0.1
@export var coyote_time: float = 0.08

var is_going_up: bool = false
var is_jumping: bool = false
var last_frame_on_floor: bool = false

@onready var jump_buffer_timer: Timer = %JumpBufferTimer
@onready var coyote_timer: Timer = %CoyoteTimer


func _ready() -> void:
	coyote_timer.timeout.connect(func(): print("coyote timeout"))


func jump() -> void:
	velocity_component.apply_jump_force(jump_velocity)
	last_frame_on_floor = true
	is_jumping = true
	is_going_up = true
	coyote_timer.stop()
	jump_buffer_timer.stop()


func tick(jump_pressed: bool, jump_released: bool) -> void:
	if has_just_landed():
		is_jumping = false

	is_going_up = velocity_component.get_velocity().y < 0 and not velocity_component.is_on_floor()

	handle_coyote_time()
	handle_jump_buffer(jump_pressed)
	handle_variable_jump_height(jump_released)

	last_frame_on_floor = velocity_component.is_on_floor()


func has_just_landed() -> bool:
	return velocity_component.is_on_floor() and not last_frame_on_floor and is_jumping


func handle_coyote_time() -> void:
	if not velocity_component.is_on_floor() and last_frame_on_floor and not is_jumping:
		print("start coyote time")
		coyote_timer.start(coyote_time)

	if is_coyote_time() and not is_jumping:
		velocity_component.stop_vertical_velocity()


func handle_jump_buffer(jump_pressed: bool) -> void:
	if jump_pressed and not velocity_component.is_on_floor():
		jump_buffer_timer.start(jump_buffer_time)


func jump_buffered() -> bool:
	return not jump_buffer_timer.is_stopped()


func is_coyote_time() -> bool:
	return not coyote_timer.is_stopped()


func handle_variable_jump_height(jump_released: bool) -> void:
	if jump_released and is_going_up:
		velocity_component.stop_vertical_velocity()
