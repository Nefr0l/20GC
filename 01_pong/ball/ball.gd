extends RigidBody2D

var speedMultiplier = 1.0

func _ready() -> void:
	position.y = Core.StartY
	position.x = get_viewport_rect().size.x / 2
	

func _on_timer_timeout() -> void:
	var dirY = randi_range(-1, 1)
	if dirY == 0:
		dirY = 1
		
	var dirX = randi_range(-1, 1)
	if dirX == 0:
		dirX = -1
	
	var move = Vector2(Core.BallSpeed * 10 * dirX, Core.BallSpeed * 10 * dirY)
	linear_velocity = move	


func _on_area_entered(area: Area2D) -> void:
	if area.get_collision_layer_value(3):
		linear_velocity *= 1.06
	print(linear_velocity)
