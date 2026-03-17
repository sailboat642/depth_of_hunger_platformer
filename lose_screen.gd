extends Control

func _ready():
	# Find all buttons that are children of this node (recursively)
	for button in find_children("*", "BaseButton", true):
		if button is Button or button is TextureButton:
			button.mouse_entered.connect(_on_any_button_hover)
			button.pressed.connect(_on_any_button_pressed)

func _on_any_button_hover():
	AudioManager.play_sfx("hover") # Plays for every button

func _on_any_button_pressed():
	AudioManager.play_sfx("select") # Plays for every button
	
func _on_retry_button_pressed() -> void:
	get_tree().paused = false
	# Replace with the exact path to your main level scene
	get_tree().change_scene_to_file("res://Platforming/platformer.tscn")
