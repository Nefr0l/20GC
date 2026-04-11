extends Node

var area : Area2D

func _ready() -> void:
	area = get_parent() as Area2D


func _physics_process(delta: float) -> void:
	area.position.y += Core.data["scrolling_speed"] * delta 
	if area.position.y > 900: queue_free()
