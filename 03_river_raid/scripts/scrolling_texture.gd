extends Sprite2D

func _process(delta: float) -> void:
	region_rect.position.y -= delta * Core.data["scrolling_speed"]
	floori(region_rect.position.y)
	Core.data["region_pos"] = region_rect.position.y
