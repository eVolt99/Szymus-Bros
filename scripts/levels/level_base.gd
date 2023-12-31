extends Node2D

@export_range(0, 100) var minimum_score := 25
@export var minimum_extra_life := 25

var item_scene: PackedScene = preload("res://scenes/world/item.tscn")
var door_scene: PackedScene = preload("res://scenes/world/door.tscn")

@onready var player: Player = $Player
@onready var spawn_position: Marker2D = $SpawnPosition
@onready var items_tilemap: TileMap = $ItemsTileMap
@onready var world_tilemap: TileMap = $WorldTileMap


func _ready() -> void:
	items_tilemap.hide()
	player.reset(spawn_position.global_position)
	limit_player_camera()
	spawn_items()
	spawn_ladders()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().paused = not get_tree().paused
		$HUD/Paused.visible = get_tree().paused


func limit_player_camera() -> void:
	var used_rect := world_tilemap.get_used_rect()
	var tile_size := world_tilemap.tile_set.tile_size
	$Player/Camera2D.limit_left = (used_rect.position.x - 5) * tile_size.x
	$Player/Camera2D.limit_right = (used_rect.end.x + 5) * tile_size.x


func spawn_items() -> void:
	var item_cells := items_tilemap.get_used_cells(0)
	for cell in item_cells:
		var data := items_tilemap.get_cell_tile_data(0, cell)
		var type: String = data.get_custom_data("type")
		if type == "door":
			var door := door_scene.instantiate()
			door.position = items_tilemap.map_to_local(cell)
			door.body_entered.connect(_on_door_body_entered)
			door.name = "Door"
			door.minimum_score = minimum_score
			$Items.add_child(door)
		elif type == "cherry" or type == "gem":
			var item: Item = item_scene.instantiate()
			item.start(type, items_tilemap.map_to_local(cell))
			item.picked_up.connect(update_score)
			$Items.add_child(item)


func spawn_ladders() -> void:
	var ladder_cells := world_tilemap.get_used_cells(0)
	for cell in ladder_cells:
		var data := world_tilemap.get_cell_tile_data(0, cell)
		var type: String = data.get_custom_data("type")
		match type:
			"ladder":
				var collision := CollisionShape2D.new()
				var collision_shape := RectangleShape2D.new()
				collision_shape.size = Vector2(10, 16)  # Not the full width of the ladder is climbable
				collision.shape = collision_shape
				collision.position = world_tilemap.map_to_local(cell)
				$Ladders.add_child(collision)


func update_score() -> void:
	GameState.score += 1
	if GameState.score >= minimum_extra_life:
		if GameState.lives < 5:
			add_life()
	if GameState.score >= minimum_score:
		$Items/Door.open()
	$HUD.change_score(GameState.score)


func update_lives() -> void:
	GameState.lives -= 1
	$HUD.change_lives(GameState.lives)


func add_life() -> void:
	GameState.lives += 1
	$HUD.change_lives(GameState.lives)


func _on_door_body_entered(_body: Node2D) -> void:
	if GameState.score >= minimum_score:
		GameState.next_level()
