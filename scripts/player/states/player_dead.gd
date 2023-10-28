class_name PlayerDead
extends PlayerState


func enter(_msg := {}) -> void:
	await get_tree().create_timer(1.5).timeout
	GameState.restart_game()
