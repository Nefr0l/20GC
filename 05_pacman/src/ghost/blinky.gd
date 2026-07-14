extends Node

var parent : Area2D

func _ready() -> void:
	parent = get_parent() as Area2D


func _process(_delta: float) -> void:
	Game.blinky_pos = parent.position
