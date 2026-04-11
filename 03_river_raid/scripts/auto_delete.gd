extends Node

var area : Area2D

func _ready() -> void:
	area = get_parent()

func _process(_delta: float) -> void:
	if area.position.y > 2048:
		area.queue_free()
		print("deleted")
