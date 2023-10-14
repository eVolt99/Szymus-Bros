extends CharacterBody2D

@export var move_speed := 50.0
@export var gravity := 900.0

var direction := 1


func _process(_delta: float) -> void:
	if position.y > 5000:
		queue_free()


func _physics_process(delta: float) -> void:
	velocity.x = move_speed * direction
	if velocity.x != 0:
		$Sprite2D.flip_h = velocity.x > 0
	velocity.y += gravity * delta
	move_and_slide()

	for c in get_slide_collision_count():
		var collision := get_slide_collision(c)
		var is_wall := collision.get_normal().x != 0
		print(collision.get_collider())
		if is_wall:
			direction = sign(collision.get_normal().x)
			velocity.y = -100
