class_name PlayerAir
extends PlayerState


func enter(msg := {}) -> void:
	if msg.has("jump"):
		player.jump()


func update(_delta: float) -> void:
	if player.velocity.y < 0:
		player.animation.play("jump_up")
	else:
		player.animation.play("jump_down")


func physics_update(delta: float) -> void:
	player.handle_movement()
	player.apply_gravity(delta)
	player.move_and_slide()

	if player.is_on_floor():
		state_machine.transition_to("PlayerIdle")
