extends Area2D

@export var speed : float
@export var bullet_node : Resource

var can_shoot : bool = true
var screen_size : Vector2


func _ready() -> void:
	screen_size = get_viewport_rect().size


func _process(delta: float) -> void:
	# Steering left and right
	var dirX = Input.get_axis("move_left", "move_right")
	if dirX != 0: position.x += speed * dirX * delta
		
	# Shooting
	if Input.is_action_pressed("shoot") and can_shoot:
		shoot()
		var t = get_node("ShootingCooldown") as Timer
		t.start()
		can_shoot = false
		
	# Accelerate and brake
	var dirY = Input.get_axis("accelerate", "brake")
	if dirY != 0: position.y += speed * dirY * delta
	position.y = clamp(position.y, 0, screen_size.y)


func _on_collision(area: Area2D) -> void:
	if area.get_collision_layer_value(2): # wall
		position.x = screen_size.x / 2
		Core.data["hp"] -= 1
	elif area.get_collision_layer_value(3): # enemy
		area.queue_free()
		Core.data["hp"] -= 1
	elif area.get_collision_layer_value(4): # fuel
		Core.data["fuel"] = min(Core.data["base_fuel"], Core.data["fuel"] + 40)
		area.queue_free()
	elif area.get_collision_layer_value(5): # bridge
		Core.data["hp"] = 0
		queue_free()


func shoot():
	var bullet = bullet_node.instantiate()
	bullet.rotation = rotation
	bullet.position = position
	get_tree().root.add_child(bullet)


func _on_shooting_cooldown_timeout() -> void:
	can_shoot = true


func _on_fuel_timer_timeout() -> void:
	Core.data["fuel"] -= 1
