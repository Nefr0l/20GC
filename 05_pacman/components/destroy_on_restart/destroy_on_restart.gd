extends Node

func _ready() -> void:
	var parent = get_parent()
	Game.game_over.connect(func(): parent.queue_free())
