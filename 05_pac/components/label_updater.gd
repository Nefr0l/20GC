extends Label

@export var prefix : String
@export var variable : String


func _process(_delta: float) -> void:
	var x = Game.get(variable)
	text = prefix + str(x)
