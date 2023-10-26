extends ParallaxBackground

@export var scrolling_speed := 160


func _ready() -> void:
	AudioPlayer.play_music("main_menu")


func _process(delta: float) -> void:
	scroll_offset.x -= scrolling_speed * delta


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select"):
		GameState.next_level()
