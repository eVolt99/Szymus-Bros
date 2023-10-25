class_name Player
extends CharacterBody2D

enum SlideCollision { DANGER = 1, ENEMY = 2, NONE = 3 }

signal hurt

@export_group("Speed")
@export var move_speed := 150.0
@export var climb_speed := 75.0
@export_group("Impulses")
@export var jump_impulse := 350.0
@export var kill_impulse := 200.0
@export_group("Properties")
@export var max_jumps := 2
@export var jump_pitch := 0.075
@export var gravity := 800.0

var can_climb := false
var last_floor := true
var last_movement_direction := 0.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var state_machine: StateMachine = $StateMachine
@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func handle_movement(speed := move_speed) -> void:
	var movement_x := Input.get_axis("left", "right")
	if movement_x != 0:
		sprite.flip_h = movement_x < 0
		velocity.x = lerp(velocity.x, speed * movement_x, 0.35)
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.95)
	last_movement_direction = movement_x


func normalize_movement(speed := move_speed) -> void:
	if is_zero_approx(velocity.length()):
		velocity = Vector2.ZERO
	else:
		velocity = velocity.normalized() * speed


func apply_gravity(delta: float, grav := gravity) -> void:
	velocity.y += grav * delta


func will_climb(event: InputEvent) -> bool:
	var climb_requested := event.is_action_pressed("up") or event.is_action_pressed("down")
	if climb_requested and can_climb:
		return true
	return false


func check_collisions() -> SlideCollision:
	var collisions := get_slide_collision_count()
	for c in collisions:
		var collision := get_slide_collision(c).get_collider()
		if collision.is_in_group("danger"):
			return SlideCollision.DANGER
		if collision.is_in_group("enemies"):
			if position.y < get_slide_collision(c).get_position().y:  # If player on top of enemy
				collision.kill()
				return SlideCollision.ENEMY
			else:
				return SlideCollision.DANGER
	return SlideCollision.NONE


func handle_collision(collision: SlideCollision) -> void:
	match collision:
		SlideCollision.DANGER:
			state_machine.transition_to("PlayerHurt")
		SlideCollision.ENEMY:
			velocity.y = -kill_impulse


func reset(new_position: Vector2, reset_lives := false) -> void:
	position = new_position
	if reset_lives:
		GameState.lives = 5
