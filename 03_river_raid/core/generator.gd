extends Node

var tile = Core.data["objects"]["cube"]


func get_boulder(x : int, y : int) -> Area2D:
	var box = load(tile).instantiate() as Area2D
	
	var sprite = box.get_node("Sprite2D") as Sprite2D
	sprite.region_rect.size = Vector2(32 * x, 32 * y)
	
	box.position.x += 16 * x
	box.position.y += 16 * y
	
	var collider = box.get_node("CollisionShape2D") as CollisionShape2D
	var shape = RectangleShape2D.new()
	shape.size = sprite.region_rect.size
	collider.shape = shape

	return box
