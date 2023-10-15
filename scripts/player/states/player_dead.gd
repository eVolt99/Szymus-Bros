class_name PlayerDead
extends PlayerState


func enter(_msg := {}) -> void:
	player.hide()
	player.collision_shape.set_deferred("disabled", false)
	player.set_physics_process(false)
	player.died.emit()
