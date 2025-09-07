class_name Player
extends CharacterBody2D

enum PlayerStates {IDLE, RUN, JUMP, FALL}

@export_category("Dependencies")
@export var animated_sprite: AnimatedSprite2D
@export var velocity_component: VelocityComponent
@export var input_component: PlayerInputComponent
@export var jump_component: JumpComponent
@export var gravity_component: GravityComponent

var state_machine: CallableStateMachine = CallableStateMachine.new()

func _ready() -> void:
	state_machine.add_state(PlayerStates.IDLE, idle_state, idle_state_enter)
	state_machine.add_state(PlayerStates.RUN, run_state, run_state_enter)
	state_machine.add_state(PlayerStates.JUMP, jump_state, jump_state_enter)
	state_machine.add_state(PlayerStates.FALL, fall_state, fall_state_enter)

	state_machine.set_initial_state(PlayerStates.IDLE)

func _physics_process(_delta: float) -> void:
	state_machine.update()

func idle_state_enter() -> void:
	print("enter idle")
	animated_sprite.play("idle")

func idle_state() -> void:
	velocity_component.decelerate_horizontal()
	velocity_component.move(self)

	if input_component.horizontal_direction != 0.0:
		state_machine.change_state(PlayerStates.RUN)
	elif input_component.jump:
		print("Jump")
		state_machine.change_state(PlayerStates.JUMP)

func run_state_enter() -> void:
	print("enter run")
	animated_sprite.play("run")

func run_state() -> void:
	do_horizontal_movement()
	if input_component.horizontal_direction == 0.0:
		state_machine.change_state(PlayerStates.IDLE)
	elif input_component.jump:
		state_machine.change_state(PlayerStates.JUMP)

func jump_state_enter() -> void:
	print("enter jump")
	animated_sprite.play("jump")

func jump_state() -> void:
	jump_component.handle_jump(self, input_component.jump, input_component.jump_just_released)
	do_horizontal_movement()

	if gravity_component.is_falling:
		state_machine.change_state(PlayerStates.FALL)

func fall_state_enter() -> void:
	print("enter fall")
	animated_sprite.play("fall")

func fall_state() -> void:
	do_horizontal_movement()
	if not gravity_component.is_falling:
		var next_state = PlayerStates.IDLE if input_component.horizontal_direction == 0.0 else PlayerStates.RUN
		state_machine.change_state(next_state)

func flip_sprite() -> void:
	if input_component.horizontal_direction != 0.0:
		animated_sprite.flip_h = true if input_component.horizontal_direction < 0 else false

func do_horizontal_movement() -> void:
	if input_component.horizontal_direction == 0.0:
		velocity_component.decelerate_horizontal()
	else:
		velocity_component.accelerate_horizontal_in_direction(input_component.horizontal_direction)
	velocity_component.move(self)
	flip_sprite()
