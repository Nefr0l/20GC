extends Area2D

@export var value_to_increase : String

func _on_area_entered(_area: Area2D) -> void:
	Game.set(value_to_increase, Game.get(value_to_increase) + 1)
	queue_free()
