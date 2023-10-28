extends Node

var music := {
	"main_menu": "res://assets/audio/main_menu.ogg",
	"level_01": "res://assets/audio/level_01.ogg",
	"level_02": "res://assets/audio/level_02.ogg",
	"level_03": "res://assets/audio/level_03.ogg",
	"level_04": "res://assets/audio/level_04.ogg",
	"level_05": "res://assets/audio/level_05.ogg",
	"end": "res://assets/audio/end.ogg",
}

var sounds := {
	"enemy_hit": "res://assets/audio/enemy_hit.ogg",
	"hurt": "res://assets/audio/hurt.ogg",
	"jump": "res://assets/audio/jump.ogg",
	"pickup": "res://assets/audio/pickup.ogg",
}

@onready var music_player: AudioStreamPlayer = $MusicPlayer


## Play SFX, optional pitch scale
func play_sfx(sfx_name: String, pitch_scale := 1.0) -> void:
	if not sounds.has(sfx_name):
		return

	var asp := AudioStreamPlayer.new()
	asp.stream = load(sounds[sfx_name])
	asp.volume_db = -18
	asp.pitch_scale = pitch_scale
	asp.name = "asp_" + sfx_name
	add_child(asp)
	asp.play()
	await asp.finished
	asp.queue_free()


## Switches music to provided string
func play_music(music_name: String) -> void:
	if not music.has(music_name):
		return

	music_player.stream = load(music[music_name])
	music_player.play()
