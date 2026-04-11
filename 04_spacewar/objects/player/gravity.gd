extends Node

var player : Area2D
var point : Node2D


func _enter_tree() -> void:
	player = get_parent() as Area2D
	point = get_tree().root.get_node("Game/Star")


func _process(delta: float) -> void:
	if not point: return
	
	var distance = point.global_position.distance_to(player.global_position)
	var multiplier = distance / 4
	multiplier = clamp(multiplier, 10, 120)
	player.position = player.position.move_toward(point.position, delta * multiplier)
