extends Area2D

var minimum_score: int

@export var closed_color := "#000000"
@export var open_color := "#047c00"


func _process(_delta: float) -> void:
	$Label.text = str(str(GameState.score).pad_zeros(2), " / ", str(minimum_score))


func open() -> void:
	$Label.label_settings.outline_color = "#047c00"
