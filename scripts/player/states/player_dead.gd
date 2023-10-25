class_name PlayerDead
extends PlayerState


func enter(_msg := {}) -> void:
	GameState.restart_game()
