class_name PlayerHurt
extends PlayerState

const KNOCKBACK_STRENGTH := -200.0

@onready var hurt_timer: Timer = $HurtTimer


func enter(_msg := {}) -> void:
	player.animation.play("hurt")
	player.lives -= 1
	if player.lives <= 0:
		state_machine.transition_to("PlayerDead")
		return
	player.velocity = Vector2(
		(KNOCKBACK_STRENGTH / 2) * signf(player.last_movement_direction), KNOCKBACK_STRENGTH
	)
	hurt_timer.start()


func physics_update(_delta: float) -> void:
	player.move_and_slide()


func exit() -> void:
	hurt_timer.stop()


func _on_hurt_timer_timeout() -> void:
	state_machine.transition_to("PlayerAir")
