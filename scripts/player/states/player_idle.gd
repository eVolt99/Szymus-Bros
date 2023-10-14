class_name PlayerIdle
extends PlayerState


func enter(_msg := {}) -> void:
	player.animation.play("idle")


func physics_update(_delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("PlayerAir")
		return

	player.handle_movement()
	if not is_equal_approx(player.velocity.x, 0):
		state_machine.transition_to("PlayerRun")


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and player.is_on_floor():
		state_machine.transition_to("PlayerAir", {jump = true})
