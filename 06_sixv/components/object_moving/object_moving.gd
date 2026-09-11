extends Node

@export var initial_direction : Vector2
@export var speed : float

var parent : Node2D
var direction : Vector2


func _ready() -> void:
	parent = get_parent() as Node2D
	direction = initial_direction


func _physics_process(delta: float) -> void:
	if parent is CharacterBody2D:
		parent.velocity.y += 900 * delta
		parent.move_and_slide()
		
	parent.position += speed * direction * delta
	
	
func change_direction(_body: Node2D) -> void:
	direction *= -1
