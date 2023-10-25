extends Node


func _ready() -> void:
	var level_num := str(GameState.current_level).pad_zeros(2)
	var level := "level_%s" % level_num
	var path := str("res://scenes/levels/", level, ".tscn")
	add_child(load(path).instantiate())
