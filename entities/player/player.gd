class_name Player
extends CharacterBody2D

enum PlayerStates { IDLE, RUN, JUMP, FALL }

@export_category("Dependencies")
@export var animated_sprite: AnimatedSprite2D
@export var velocity_component: VelocityComponent
@export var input_component: PlayerInputComponent
@export var jump_component: JumpComponent
@export var animation_handler: AnimationHandlerComponent

var state_machine: CallableStateMachine = CallableStateMachine.new()
var current_animation: String


func _ready() -> void:
	state_machine.add_state(PlayerStates.IDLE, idle_state, idle_state_enter)
	state_machine.add_state(PlayerStates.RUN, run_state, run_state_enter)
	state_machine.add_state(PlayerStates.JUMP, jump_state, jump_state_enter)
	state_machine.add_state(PlayerStates.FALL, fall_state, fall_state_enter, fall_state_exit)

	state_machine.set_initial_state(PlayerStates.IDLE)


func _physics_process(delta: float) -> void:
	velocity_component.apply_gravity(delta)
	input_component.tick()
	state_machine.update(delta)


func idle_state_enter() -> void:
	animation_handler.play_animation("idle")


func idle_state(_delta: float) -> void:
	do_horizontal_movement()

	if input_component.horizontal_direction != 0.0:
		state_machine.change_state(PlayerStates.RUN)
	elif input_component.jump:
		state_machine.change_state(PlayerStates.JUMP)


func run_state_enter() -> void:
	animation_handler.play_animation("run")


func run_state(_delta: float) -> void:
	do_horizontal_movement()

	if input_component.jump:
		state_machine.change_state(PlayerStates.JUMP)
	elif velocity_component.is_falling:
		state_machine.change_state(PlayerStates.FALL)
	elif input_component.horizontal_direction == 0.0:
		state_machine.change_state(PlayerStates.IDLE)


func jump_state_enter() -> void:
	animation_handler.play_animation("jump")
	jump_component.jump()


func jump_state(_delta: float) -> void:
	jump_component.tick(input_component.jump, input_component.jump_just_released)
	do_horizontal_movement()

	if velocity_component.is_falling:
		state_machine.change_state(PlayerStates.FALL)


func fall_state_enter() -> void:
	animation_handler.play_animation("fall")


func fall_state(_delta: float) -> void:
	jump_component.tick(input_component.jump, input_component.jump_just_released)
	do_horizontal_movement()

	var coyote_jump: bool = input_component.jump and jump_component.is_coyote_time()
	var buffered_jump = velocity_component.is_on_floor() and jump_component.jump_buffered()

	if coyote_jump or buffered_jump:
		state_machine.change_state(PlayerStates.JUMP)
	elif velocity_component.is_on_floor():
		state_machine.change_state(PlayerStates.IDLE)


func fall_state_exit() -> void:
	jump_component.tick(input_component.jump, input_component.jump_just_released)


func do_horizontal_movement() -> void:
	velocity_component.accelerate_horizontal_in_direction(input_component.horizontal_direction)
	velocity_component.move()

	flip_sprite()


func flip_sprite() -> void:
	if input_component.horizontal_direction != 0.0:
		animated_sprite.flip_h = true if input_component.horizontal_direction < 0 else false
