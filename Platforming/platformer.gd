extends Node2D

@export var music: AudioStream
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioManager.play_music(music)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func on_game_win(body):
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://Screens/end_screen.tscn")
