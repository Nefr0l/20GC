extends Node

var parent : Node
@export var var_to_spy : String
@export var var_to_send : String


func _ready() -> void:
	parent = get_parent() as Node2D
	
	if parent.get(var_to_spy) == null:
		printerr("Spy: variable not found in parent")
		queue_free()
		
	if Game.get(var_to_send) == null:
		printerr("Spy: variable not found in game manager")
		queue_free()


func _process(_delta: float) -> void:
	var value = parent.get(var_to_spy)
	Game.set(var_to_send, value)
