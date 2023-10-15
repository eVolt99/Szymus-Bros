class_name PlayerAir
extends PlayerState

var jumps_left: int

@onready var double_jump_timer: Timer = $DoubleJumpTimer


func enter(msg := {}) -> void:
	if msg.has("jump"):
		jumps_left = player.max_jumps
		jump()


func update(_delta: float) -> void:
	if player.velocity.y < 0:
		player.animation.play("jump_up")
	else:
		player.animation.play("jump_down")


func physics_update(delta: float) -> void:
	player.handle_movement()
	player.apply_gravity(delta)
	player.move_and_slide()
	var collision := player.check_collisions()
	if collision != Player.SlideCollision.NONE:
		player.handle_collision(collision)
		return

	if player.is_on_floor():
		double_jump_timer.stop()
		state_machine.transition_to("PlayerIdle")


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and jumps_left > 0:
		jump()


func jump() -> void:
	if double_jump_timer.is_stopped():
		player.velocity.y = (
			-player.jump_impulse if jumps_left == player.max_jumps else -player.jump_impulse * 0.75
		)
		jumps_left -= 1
		double_jump_timer.start()
