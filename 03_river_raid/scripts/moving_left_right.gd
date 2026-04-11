extends Area2D

@export var bound_limited : bool

var direction : int
var margin : float

func _enter_tree() -> void:
	while direction == 0: direction = randi_range(-1, 1)
	
	var sprite = get_node("Sprite2D") as Sprite2D
	margin = sprite.texture.get_size().x / 2


func _process(delta: float) -> void:
	position.x += Core.data["enemy_x_speed"] * delta * direction
	
	if not bound_limited and (position.x < margin or position.x > get_viewport_rect().size.x - margin):
		direction *= -1


func _on_area_entered(area: Area2D) -> void:
	if area.get_collision_layer_value(2) and bound_limited:
		direction *= -1
