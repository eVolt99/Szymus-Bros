class_name State
extends Node

var state_machine: StateMachine


func enter(_msg := {}) -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass


func unhandled_input(_event: InputEvent) -> void:
	pass


func exit() -> void:
	pass
