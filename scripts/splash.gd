extends CanvasLayer

var main_menu := preload("res://scenes/levels/level_01.tscn")


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_packed(main_menu)
