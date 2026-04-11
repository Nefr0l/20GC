extends Area2D

@export var speed : int
var padding : int = 100
var rot_speed : int = 0
var second_speed_multiplier

func _ready() -> void:
	rot_speed = randi_range(-10,10) * 3 
	second_speed_multiplier = randf_range(0.7,1.4)
	var size = get_viewport_rect().size
	position.x = size.x + padding
	position.y = randi_range(padding, size.y - padding)


func _physics_process(delta: float) -> void:
	position.x -= speed * Core.SpeedMultiplier * second_speed_multiplier
	rotation_degrees += rot_speed  * delta
	
	if position.x < -500:
		queue_free()
