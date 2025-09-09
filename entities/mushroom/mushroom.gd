extends CharacterBody2D

enum MushroomStates { IDLE, MOVE }

@export_category("Dependencies")
@export var animated_sprite: AnimatedSprite2D
@export var velocity_component: VelocityComponent
@export var movement_component: RayCastMoveComponent
@export var animation_handler: AnimationHandlerComponent

var state_machine: CallableStateMachine = CallableStateMachine.new()
var current_animation: String


func _ready() -> void:
	state_machine.add_state(MushroomStates.IDLE, idle_state, idle_state_enter)
	state_machine.add_state(MushroomStates.MOVE, move_state, move_state_enter)

	state_machine.set_initial_state(MushroomStates.IDLE)

func _physics_process(delta: float) -> void:
	state_machine.update(delta)
	velocity_component.apply_gravity(delta)

func idle_state_enter() -> void:
	animation_handler.play_animation("idle")


func idle_state(delta: float) -> void:
	movement_component.tick(delta)
	velocity_component.accelerate_horizontal_in_direction(0)

	if movement_component.direction != 0:
		state_machine.change_state(MushroomStates.MOVE)


func move_state_enter() -> void:
	animation_handler.play_animation("run")
	animated_sprite.flip_h = movement_component.direction != -1


func move_state(delta: float) -> void:
	movement_component.tick(delta)
	velocity_component.accelerate_horizontal_in_direction(movement_component.direction)
	velocity_component.move()

	if movement_component.direction == 0:
		state_machine.change_state(MushroomStates.IDLE)
