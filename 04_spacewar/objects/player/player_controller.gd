extends Area2D

@export var player : int

var turn_speed : int = Core.get("turn_speed")
var max_speed : float = Core.get("max_speed")
var min_speed : float = Core.get("min_speed")

var speed : float = 1
var can_shoot : bool = false
var prefix : String


func _enter_tree() -> void:
	prefix = "p" + str(player) + "_"
	
	
func _physics_process(delta: float) -> void:
	# turning
	var dir = Input.get_axis(prefix + "left", prefix + "right")
	if dir: rotation_degrees += dir * delta * turn_speed
	
	# acceleration
	var accelerating : bool = Input.is_action_pressed(prefix + "accelerate")
	var braking : bool = Input.is_action_pressed(prefix + "brake")
	
	if accelerating: 
		var boost = max(speed, max_speed - speed)
		speed = min(max_speed, speed + boost * 20 * delta)
	elif braking: 
		speed = max(min_speed - 100, speed - min_speed)		
	else:													
		speed = max(min_speed, speed - speed * 3 * delta)
	
	position += Vector2(speed, 0).rotated(rotation) * delta	
	position = Core.clamp_position(position)
	
	#shooting
	if accelerating and can_shoot:
		Audio.play_sound(Audio.sounds["shoot"], 0.2)
		shoot()
		can_shoot = false
		
		
func shoot() -> void:
	var bullet = load("res://objects/bullet/bullet.tscn").instantiate() as Node2D
	get_tree().root.add_child(bullet)
	bullet.set("belongs_to", get_instance_id())
	bullet.set("player_id", player)
	bullet.position = position
	bullet.rotation = rotation


func _on_shooting_cooldown_timeout() -> void:
	can_shoot = true
	
	
func _on_area_entered(area: Area2D) -> void:
	if area.get_collision_layer_value(1):
		Core.player_won = 0
		Core.emit_particles(position, Core.big_explosion_path)
		Core.game_over()
		queue_free()
	elif area.get_collision_layer_value(3):
		Core.player_won = 3 - player
		Core.emit_particles(position, Core.big_explosion_path)
		Core.game_over()	
		queue_free()	
