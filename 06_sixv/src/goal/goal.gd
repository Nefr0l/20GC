extends Node


func on_collision(_area: Area2D) -> void:
	Audio.play_sound("win")
	Game.win = true
