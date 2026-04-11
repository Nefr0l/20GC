extends Area2D

@export var follow_y : bool
@export var follow_x : bool
@export var to_follow : Area2D

func _physics_process(delta: float) -> void:
	if follow_x:
		position.x = to_follow.position.x
	
	if follow_y:
		position.y = to_follow.position.y
