extends RigidBody2D

signal player_dead
  
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("accelerate"):
		gravity_scale = 0
		linear_velocity.y = max(-300, linear_velocity.y - 30)           
	else:
		gravity_scale = 1
		
	
func _on_collision(area: Area2D) -> void:
	player_dead.emit()
