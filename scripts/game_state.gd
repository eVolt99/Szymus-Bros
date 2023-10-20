extends Node

var full_screen := {
	true: DisplayServer.WINDOW_MODE_FULLSCREEN, false: DisplayServer.WINDOW_MODE_WINDOWED
}
var is_full_screen := false
var num_levels := 2
var current_level := 0

var game_scene := "res://scenes/main.tscn"
var title_screen := "res://scenes/title.tscn"


func restart() -> void:
	current_level = 0
	get_tree().change_scene_to_file(title_screen)


func next_level() -> void:
	current_level += 1
	if current_level <= num_levels:
		get_tree().change_scene_to_file(game_scene)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fullscreen"):
		is_full_screen = not is_full_screen
		DisplayServer.window_set_mode(full_screen[is_full_screen])
