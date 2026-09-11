extends Node

var parent : AnimatedSprite2D


func _ready() -> void:
	parent = get_parent() as AnimatedSprite2D


func flip_y() -> void:
	parent.flip_v = !parent.flip_v


func flip_x() -> void:
	parent.flip_h = !parent.flip_h
	
	
func play_animation(animation : String = "idle") -> void:
	parent.play(animation)
	
