class_name PlayerClimb
extends PlayerState


func enter(_msg := {}) -> void:
	player.animation.play("climb")


func update(_delta: float) -> void:
	if is_equal_approx(player.velocity.y, 0.0):
		player.animation.pause()
	else:
		player.animation.play()


func physics_update(_delta: float) -> void:
	player.handle_movement()
	player.velocity.y = handle_climbing()
	player.move_and_slide()
	var collision := player.check_collisions()
	if collision != Player.SlideCollision.NONE:
		player.handle_collision(collision)
		return

	if not player.can_climb:
		if not player.is_on_floor():
			state_machine.transition_to("PlayerAir")
		elif is_equal_approx(player.velocity.x, 0.0):
			state_machine.transition_to("PlayerIdle")
		else:
			state_machine.transition_to("PlayerRun")


func handle_climbing() -> float:
	var movement_y := Input.get_axis("down", "up")
	if movement_y != 0:
		return lerp(player.velocity.y, movement_y * player.climb_speed, 0.35)
	else:
		return lerp(player.velocity.y, 0.0, 0.90)
