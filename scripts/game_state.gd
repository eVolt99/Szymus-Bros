extends Node

var full_screen := {
	true: DisplayServer.WINDOW_MODE_FULLSCREEN, false: DisplayServer.WINDOW_MODE_WINDOWED
}
var is_full_screen := false
var num_levels := 6
var current_level := 0

var game_scene := "res://scenes/main.tscn"
var main_menu := "res://scenes/hud/main_menu.tscn"
var end_scene := "res://scenes/hud/end.tscn"

var score := 0
var lives := 5


func restart_game() -> void:
	current_level = 0
	lives = 5
	get_tree().change_scene_to_file(main_menu)


func restart_level() -> void:
	score = 0
	get_tree().reload_current_scene()


func next_level() -> void:
	current_level += 1
	if current_level <= num_levels:
		score = 0
		get_tree().change_scene_to_file(game_scene)
	elif current_level > num_levels:
		get_tree().change_scene_to_file(end_scene)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fullscreen"):
		is_full_screen = not is_full_screen
		DisplayServer.window_set_mode(full_screen[is_full_screen])
