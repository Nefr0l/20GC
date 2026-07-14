extends Node

var parent : Area2D

func _ready() -> void:
	if get_parent() is Area2D:
		parent = get_parent() as Area2D
	else:
		print("Error setting up parent")
		return
		
	parent.position = Game.round_position(parent.position)
	queue_free()
