extends Control


func _ready() -> void:
	AudioPlayer.play_music("main_menu")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select"):
		GameState.next_level()
