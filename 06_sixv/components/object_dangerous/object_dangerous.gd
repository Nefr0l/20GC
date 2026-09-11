extends Node


func _on_area_entered(_area: Area2D) -> void:
	Game.on_player_death.emit()
