class_name PlayerRun
extends PlayerState


func enter(_msg := {}) -> void:
	player.animation.play("run")


func physics_update(delta: float) -> void:
	player.handle_movement()
	player.apply_gravity(delta)
	player.move_and_slide()
	var collision := player.check_collisions()
	if collision != Player.SlideCollision.NONE:
		player.handle_collision(collision)
		return

	if is_equal_approx(player.velocity.x, 0):
		state_machine.transition_to("PlayerIdle")
	elif not player.is_on_floor():
		if player.last_floor:
			state_machine.transition_to("PlayerCoyote")
		else:
			state_machine.transition_to("PlayerAir")
	player.last_floor = player.is_on_floor()


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and player.is_on_floor():
		state_machine.transition_to("PlayerAir", {jump = true})

	if player.will_climb(event):
		state_machine.transition_to("PlayerClimb")
