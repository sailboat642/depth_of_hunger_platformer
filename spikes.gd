extends Node2D

@export var damage_amount = 8


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.apply_damage_to_player(damage_amount)
		
