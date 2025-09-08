class_name CallableStateMachine
extends Node

var state_dict: Dictionary[int, CallableState] = {}
var current_state: int = -1

func add_state(state_id: int, normal_callable: Callable, enter_callable: Callable = Callable(), exit_callable: Callable = Callable()) -> void:
	state_dict[state_id] = CallableState.new(enter_callable, normal_callable, exit_callable)

func set_initial_state(initial_state: int) -> void:
	if state_dict.has(initial_state):
		set_state(initial_state)

func update(delta: float) -> void:
	if state_dict.has(current_state):
		state_dict[current_state].normal.call(delta)

func change_state(state_id: int) -> void:
	if state_dict.has(state_id):
		set_state.call_deferred(state_id)

func set_state(state_id: int) -> void:
	if state_id == current_state:
		return

	print("changing to state %d" % state_id)

	if state_dict.has(current_state) and state_dict[current_state].exit:
		state_dict[current_state].exit.call()

	current_state = state_id
	if state_dict[current_state].enter:
		state_dict[current_state].enter.call()

class CallableState:
	var enter: Callable
	var normal: Callable
	var exit: Callable

	func _init(enter_callable: Callable, normal_callable: Callable, exit_callable: Callable) -> void:
		self.enter = enter_callable
		self.normal = normal_callable
		self.exit = exit_callable
