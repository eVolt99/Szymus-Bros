class_name Player
extends CharacterBody2D

enum SlideCollision { DANGER = 1, ENEMY = 2, NONE = 3 }

signal died
signal lives_changed(new_lives: int)

@export var move_speed := 150.0
@export var climb_speed := 100.0
@export var jump_impulse := 350.0
@export var gravity := 800.0
@export var kill_impulse := 200.0
@export var max_jumps := 2

var can_climb := false
var last_floor := false
var last_movement_direction := 0.0
var lives := 5:
	set = set_lives

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var state_machine: StateMachine = $StateMachine
@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func handle_movement() -> void:
	var movement_x := Input.get_axis("left", "right")
	if movement_x != 0:
		sprite.flip_h = movement_x < 0
		velocity.x = lerp(velocity.x, move_speed * movement_x, 0.35)
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.95)
	last_movement_direction = movement_x


func apply_gravity(delta: float, grav := gravity) -> void:
	velocity.y += grav * delta


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


func set_lives(new_lives: int) -> void:
	lives = new_lives
	lives_changed.emit(lives)


func reset(new_position: Vector2) -> void:
	position = new_position
	lives = 5
	show()
	$CollisionShape2D.set_deferred("disabled", false)
