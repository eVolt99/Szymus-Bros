class_name PlayerAir
extends PlayerState

var can_jump: bool
var jump_count := 0

@onready var double_jump_timer: Timer = $DoubleJumpTimer


func enter(msg := {}) -> void:
	can_jump = false
	if msg.has("jump"):
		jump_count = 0
		can_jump = true
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
	if event.is_action_pressed("jump") and not player.is_on_floor():
		jump()

	if player.will_climb(event):
		state_machine.transition_to("PlayerClimb")


func jump() -> void:
	if can_jump and jump_count < player.max_jumps:
		player.velocity.y = -player.jump_impulse
		double_jump_timer.start()
		can_jump = false
		jump_count += 1


func _on_double_jump_timer_timeout() -> void:
	can_jump = true
