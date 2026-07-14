extends Node

@export var value_name : String


func _ready() -> void:
	if value_name in Game:
		Game.set(value_name, self)
