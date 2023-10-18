class_name Ladder
extends Area2D


func _on_body_exited(player: Player) -> void:
	print("can not climb now")
	player.can_climb = false


func _on_body_entered(player: Player) -> void:
	print("can climb now")
	player.can_climb = true
