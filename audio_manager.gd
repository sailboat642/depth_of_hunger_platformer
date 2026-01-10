extends Node

# Dictionary to hold preloaded sounds for easy access
var sounds = {
	"musquito_buzzing": "res://Audio/SoundEffects/FLYSOUND.wav"
}

@onready var music_player = AudioStreamPlayer.new()

func _ready():
	add_child(music_player)
	music_player.bus = "Music"
	
func play_music(track: AudioStream):
	if track == null: return
	
	if music_player.stream == track and music_player.playing:
		return # Don't restart if the same track is already playing
	
	music_player.stream = track
	music_player.play()

func play_sfx(sound_name: String, position: Vector2 = Vector2.ZERO):
	if not sounds.has(sound_name): return
	
	var stream = sounds[sound_name]
	
	if position == Vector2.ZERO:
		# Use a normal player for UI/Global sounds
		var asp = AudioStreamPlayer.new()
		asp.stream = stream
		asp.bus = "UI"
		add_child(asp)
		asp.play()
		asp.finished.connect(asp.queue_free)
		return asp
	else:
		# Use a 2D player for world sounds
		var asp2d = AudioStreamPlayer2D.new()
		asp2d.stream = stream
		asp2d.global_position = position
		asp2d.bus = "SFX"
		add_child(asp2d)
		asp2d.play()
		asp2d.finished.connect(asp2d.queue_free)
		return asp2d
		
