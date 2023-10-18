class_name Ladder
extends Area2D


func _on_body_exited(player: Player) -> void:
	player.can_climb = false


func _on_body_entered(player: Player) -> void:
	player.can_climb = true
