class_name PlayerIdle
extends PlayerState


func enter(_msg := {}) -> void:
	player.animation.play("idle")


func physics_update(_delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("PlayerAir")
		return

	player.handle_movement()
	player.move_and_slide()
	var collision := player.check_collisions()
	if collision != Player.SlideCollision.NONE:
		player.handle_collision(collision)
		return
	if not is_zero_approx(player.velocity.x):
		state_machine.transition_to("PlayerRun")


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and player.is_on_floor():
		state_machine.transition_to("PlayerAir", {jump = true})

	if player.will_climb(event):
		state_machine.transition_to("PlayerClimb")
