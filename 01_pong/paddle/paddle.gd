extends RigidBody2D

@export var player : int

func _ready() -> void:	
	position.y = Core.StartY
		
	if player == 1:
		position.x = Core.Padding
	elif player == 2:
		position.x = get_viewport_rect().size.x - Core.Padding


func _process(delta: float) -> void:
	var p = "p" + str(player)
	
	if Input.is_action_pressed(p + "_up"):
		position.y = max(position.y - 6, Core.BoundUp)
	elif Input.is_action_pressed(p + "_down"):
		position.y = min(position.y + 6, Core.BoundDown)
		
	
	
