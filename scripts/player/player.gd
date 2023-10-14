class_name Player
extends CharacterBody2D

@export var move_speed := 150.0
@export var jump_impulse := 350.0
@export var gravity := 800.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation: AnimationPlayer = $AnimationPlayer


func handle_movement() -> void:
	var movement_x := Input.get_axis("left", "right")
	if movement_x != 0:
		sprite.flip_h = movement_x < 0
	velocity.x = move_speed * movement_x


func apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta


func jump() -> void:
	velocity.y = -jump_impulse
