extends Node

var parent : Node2D
var step : int = 16

func _ready() -> void:
	if get_parent() is Node2D:
		parent = get_parent() as Node2D
	else:
		print("Error setting up parent")
		return
		
	parent.position = parent.position.snapped(Vector2(step,step))
	queue_free()
