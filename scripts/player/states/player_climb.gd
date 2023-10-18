class_name PlayerClimb
extends PlayerState


func enter(_msg := {}) -> void:
	player.velocity.y = 0
	player.animation.play("climb")


func update(_delta: float) -> void:
	if is_zero_approx(player.velocity.length()):
		player.animation.pause()
	else:
		player.animation.play()


func physics_update(_delta: float) -> void:
	player.handle_movement(player.climb_speed)
	handle_climbing()
	player.move_and_slide()
	var collision := player.check_collisions()
	if collision != Player.SlideCollision.NONE:
		player.handle_collision(collision)
		return

	if not player.can_climb:
		if not player.is_on_floor():
			state_machine.transition_to("PlayerAir")

	if player.is_on_floor():
		if is_zero_approx(player.velocity.length()):
			state_machine.transition_to("PlayerIdle")
		else:
			state_machine.transition_to("PlayerRun")


func handle_climbing() -> void:
	var movement_y := Input.get_axis("down", "up")
	if movement_y != 0:
		player.velocity.y = lerp(player.velocity.y, movement_y * -player.climb_speed, 0.35)
		player.normalize_movement(player.climb_speed)
	else:
		player.velocity.y = lerp(player.velocity.y, 0.0, 0.95)
