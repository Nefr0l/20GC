extends Label

@export var prefix : String
@export var variable : String


func _process(_delta: float) -> void:
	var x = Core.get(variable)
	text = prefix + str(x)
