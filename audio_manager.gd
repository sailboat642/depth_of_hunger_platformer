extends Node

# Dictionary to hold preloaded sounds for easy access
var sounds = {
	"musquito_buzzing": "res://Audio/SoundEffects/FLYSOUND.wav",
	"jump_sound" :"res://Audio/SoundEffects/jumping.wav", # something springy
	"player_acid": "res://Audio/SoundEffects/acidsoundlonger.wav", # constant hissing or sizzling
	"water_splash": "",
	"character_dying": "res://Audio/SoundEffects/dyingsoundmusic.wav", # lose game sound
	"rumbling": "res://Audio/SoundEffects/rumblesound.wav", # this will be played to signify rise and fall of acid, the humans belly rumbling, like a roar
	"slurp": "res://Audio/SoundEffects/slurp.wav", # musquito sucking (for potential lock and key mechanic of mosquito)
	"vines_reseading": "", # for gate opening
	"collecting_objective": "", # pickup key object
	"collecting_resource": "", # pickup object
	"splashing_of_platform": "res://Audio/SoundEffects/watersplashing.wav", # for floating objects, gentle splashing when character lands
	#ui
	"hover": "res://Audio/SoundEffects/menu_sound_effects_-_all_sounds/SoundMenuMove.wav",
	"select": "res://Audio/SoundEffects/menu_sound_effects_-_all_sounds/SoundMessageWarning.wav",
	
	# narrative
	"air_rushing": "", # while the mosquito is falling from 
	"thud": "", # strong landing, cinematic
	"weak_landing": "", # crunchy, foot step on snow, crumbling  paper
	"munching_sound": "", #  like a landslide, make it comical
	"flushing": "",
	"level_complete": "", # holy aura like
	"loud_click": "", # flipping of switch or finger snap
	
	# music
	"title_music_track": "",
	"": "",
	
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
	
	var stream = load(sounds[sound_name])
	
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
		
