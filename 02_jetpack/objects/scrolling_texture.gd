extends Sprite2D

@export var scrolling_speed : float

func _process(delta: float) -> void:
	region_rect.size.x += scrolling_speed * delta * Core.SpeedMultiplier
