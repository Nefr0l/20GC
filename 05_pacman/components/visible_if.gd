extends Control

@export var boolean_name : String
var can_show : bool = false


func _process(_delta: float) -> void:
	can_show = Game.get(boolean_name)
	visible = can_show
		
		
		
