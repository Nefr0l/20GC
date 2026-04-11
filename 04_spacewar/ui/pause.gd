extends Control

func _ready() -> void:
	hide()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause") and Core.is_game_over == false:
		hide() if visible else show()
		get_tree().paused = visible
