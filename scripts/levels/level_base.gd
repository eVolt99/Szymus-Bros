extends Node2D

var item_scene: PackedScene = preload("res://scenes/world/item.tscn")

@onready var player: Player = $Player
@onready var spawn_position: Marker2D = $SpawnPosition
@onready var items_tilemap: TileMap = $ItemsTileMap
@onready var world_tilemap: TileMap = $WorldTileMap


func _ready() -> void:
	items_tilemap.hide()
	player.reset(spawn_position.global_position)
	limit_player_camera()
	spawn_items()


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
		var item: Item = item_scene.instantiate()
		item.start(type, items_tilemap.map_to_local(cell))
		$Items.add_child(item)
