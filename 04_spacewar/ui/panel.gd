extends Control

@export var boolean_name : String
var boolean : bool = false


func _process(_delta: float) -> void:
	boolean = Core.get(boolean_name)
	show() if boolean == true else hide()
		
		
		
