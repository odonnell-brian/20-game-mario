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

func has_just_landed(body: CharacterBody2D) -> bool:
	return body.is_on_floor() and not last_frame_on_floor and is_jumping

func should_jump(body: CharacterBody2D, jump_pressed: bool) -> bool:
	return jump_pressed and (body.is_on_floor() or not coyote_timer.is_stopped())

func handle_jump(body: CharacterBody2D, jump_pressed: bool, jump_released: bool) -> void:
	if has_just_landed(body):
		is_jumping = false

	if should_jump(body, jump_pressed):
		jump()

	handle_coyote_time(body)
	handle_jump_buffer(body, jump_pressed)
	handle_variable_jump_height(jump_released)

	is_going_up = velocity_component.velocity.y < 0 and not body.is_on_floor()
	last_frame_on_floor = body.is_on_floor()

func handle_coyote_time(body: CharacterBody2D) -> void:
	if body.is_on_floor() and last_frame_on_floor and not is_jumping:
		coyote_timer.start(coyote_time)

	if not coyote_timer.is_stopped() and not is_jumping:
		velocity_component.velocity.y = 0

func handle_jump_buffer(body: CharacterBody2D, jump_pressed: bool) -> void:
	if jump_pressed and not body.is_on_floor():
		jump_buffer_timer.start(jump_buffer_time)

	if body.is_on_floor() and not jump_buffer_timer.is_stopped():
		jump()

func handle_variable_jump_height(jump_released: bool) -> void:
	if jump_released and is_going_up:
		velocity_component.velocity.y = 0

func jump() -> void:
	velocity_component.velocity.y = jump_velocity
	jump_buffer_timer.stop()
	is_jumping = true
	coyote_timer.stop()
