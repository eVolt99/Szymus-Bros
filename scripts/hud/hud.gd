extends CanvasLayer

@onready var score: Label = $MarginContainer/Score
@onready var lives := $MarginContainer/LivesContainer.get_children()


func change_lives(new_lives: int) -> void:
	for i in lives.size():
		lives[i].visible = i < new_lives


func change_score(new_score: int) -> void:
	score.text = str(new_score).pad_zeros(2)
