extends Area2D

func _ready() -> void:
	Game.power_pellets.append(Game.round_position(position))


func on_eat(_area: Area2D) -> void:
	Game.set_frightened_mode.emit()
	queue_free()
