extends CharacterBody2D

@export var move_speed := 50.0
@export var gravity := 900.0
@export var wall_bump_impulse := 100.0

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
	if is_on_wall():
		direction = -direction
		velocity.y = -wall_bump_impulse


func kill() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	set_physics_process(false)
	$AnimationPlayer.play("death")
	await $AnimationPlayer.animation_finished
	queue_free()
