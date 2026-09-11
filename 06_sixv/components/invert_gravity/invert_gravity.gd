extends Node

var parent : CharacterBody2D

signal gravity_flipped


func _ready() -> void:
	parent = get_parent() as CharacterBody2D
	
	
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("invert") and (parent.is_on_floor() or parent.is_on_ceiling()):
		Game.gravity.y *= -1
		gravity_flipped.emit()
		Audio.play_sound("gravity", 0.3)
		
