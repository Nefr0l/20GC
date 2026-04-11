extends Area2D

var speed : float = 400.0

func _process(delta: float) -> void:
	position += Vector2(0, -speed) * delta


func _on_area_entered(area: Area2D) -> void:
	if area.get_collision_layer_value(3):
		Core.data['score'] += 200
	elif area.get_collision_layer_value(4):
		Core.data['score'] += 500
	elif area.get_collision_layer_value(5): # propably unsafe but idk, it works
		Core.data['score'] += 1000
		area.get_node("Sprite2D").queue_free()
		area.get_node("CollisionShape2D").queue_free()
		queue_free()
		return
	
	area.queue_free()
	queue_free()


func _on_destroy_timer_timeout() -> void:
	queue_free()
