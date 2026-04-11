extends Control


func _ready() -> void: 
	show()
	get_tree().paused = true
   

func _process(delta: float) -> void:
	if visible and Input.is_anything_pressed() and not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		get_tree().paused = false
		hide()
		
