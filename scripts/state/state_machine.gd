extends Node

@export var initial_state: State

var state := initial_state


func _ready() -> void:
	for child in get_children():
		if child is State:
			child.state_machine = self


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


func _unhandled_input(event: InputEvent) -> void:
	state.unhandled_input(event)


func transition_to(new_state_name: String, msg := {}) -> void:
	if not has_node(new_state_name):
		print("State not found: " + new_state_name)
		return

	var new_state := get_node(new_state_name)
	if state:
		state.exit()
	new_state.enter(msg)
	state = new_state
