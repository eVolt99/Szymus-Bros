class_name PlayerCoyote
extends PlayerState

@export var coyote_gravity := 300.0

var coyote_frames := 6.0

@onready var coyote_timer: Timer = $CoyoteTimer


func enter(_msg := {}) -> void:
	coyote_timer.start(coyote_frames / 60.0)


func physics_update(delta: float) -> void:
	player.handle_movement()
	player.apply_gravity(delta, coyote_gravity)
	player.move_and_slide()
	var collision := player.check_collisions()
	if collision != Player.SlideCollision.NONE:
		player.handle_collision(collision)
		return


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		state_machine.transition_to("PlayerAir", {jump = true})


func exit() -> void:
	coyote_timer.stop()


func _on_coyote_timer_timeout() -> void:
	state_machine.transition_to("PlayerAir")
