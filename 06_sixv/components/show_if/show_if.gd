extends Node

@export var condition1 : String
@export var condition1_status : bool
@export var condition2 : String
@export var condition2_status : bool

var parent : Control

func _ready() -> void:
	parent = get_parent() as Control
	
	
func _process(_delta: float) -> void:
	var state1 = Game.get(condition1) == condition1_status
	var state2 = true if condition2 == "" else Game.get(condition2) == condition2_status
	parent.visible = state1 and state2
