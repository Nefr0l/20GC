extends Area2D

signal checkpoint_entered

func _on_area_entered(_area: Area2D) -> void:
	Game.checkpoint = position
	checkpoint_entered.emit()
	Audio.play_sound("checkpoint")
	print("Checkpoint saved")
