extends Node2D


	
func open_gate(body) -> void:
	if body.is_in_group("player"):
		AudioManager.play_sfx("vines_receading")
		$TileMapLayer.collision_enabled = false
		fade_and_destroy()
		
func fade_and_destroy() -> void:
	var tween = create_tween()
	# Fades the opacity from 100% to 0% over 1.0 seconds
	tween.tween_property(self, "modulate:a", 0.0, 1.0)
	# Once invisible, remove it from the game tree
	tween.finished.connect(func(): queue_free())
