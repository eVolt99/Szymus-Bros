class_name Item
extends Area2D

signal picked_up


func start(type: String, new_position: Vector2) -> void:
	position = new_position
	$AnimationPlayer.play(type)


func _on_body_entered(_body: Player) -> void:
	picked_up.emit()
	queue_free()
