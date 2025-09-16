class_name PlayerInputComponent
extends Node2D

const DEFAULT_BUFFER: Array[bool] = [false]

var horizontal_direction: float = 0.0
var jump: bool = false
var jump_just_released: bool = false

var jump_input_buffer: Array[bool] = DEFAULT_BUFFER.duplicate()
var jump_released_buffer: Array[bool] = DEFAULT_BUFFER.duplicate()

var enabled: bool = true

func tick() -> void:
	if not enabled:
		return

	horizontal_direction = Input.get_axis("move_left", "move_right")
	jump = buffer_input(jump_input_buffer, Input.is_action_just_pressed("jump"))
	jump_just_released = buffer_input(jump_released_buffer, Input.is_action_just_released("jump"))


func buffer_input(buffer: Array[bool], value: bool) -> bool:
	buffer.pop_front()
	buffer.append(value)

	for val in buffer:
		if val:
			return true

	return false


func set_enabled(is_enabled: bool) -> void:
	enabled = is_enabled

	if not enabled:
		reset()


func reset() -> void:
	horizontal_direction = 0.0
	jump = false
	jump_just_released = false
