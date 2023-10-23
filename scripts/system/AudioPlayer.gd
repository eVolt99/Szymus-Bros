extends Node

var music := {
	"main_menu": "res://assets/audio/main_menu.ogg", "level_01": "res://assets/audio/level_01.ogg"
}

var sounds := {
	"enemy_hit": "res://assets/audio/enemy_hit.ogg",
	"hurt": "res://assets/audio/hurt.ogg",
	"jump": "res://assets/audio/jump.ogg",
	"pickup": "res://assets/audio/pickup.ogg",
}

@onready var music_player: AudioStreamPlayer = $MusicPlayer


func play_sfx(sfx_name: String) -> void:
	var asp := AudioStreamPlayer.new()
	asp.stream = load(sounds[sfx_name])
	asp.volume_db = -18
	asp.name = "asp_" + sfx_name
	add_child(asp)
	asp.play()
	await asp.finished
	asp.queue_free()


func play_music(music_name: String) -> void:
	music_player.stream = load(music[music_name])
	asp.play()
