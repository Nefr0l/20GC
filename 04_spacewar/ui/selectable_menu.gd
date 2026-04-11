extends Node

@export var pause_condition_name : String 
var pause_condition : bool

var buttons : Array = [Button]
var selected : int = 0


func _ready() -> void:
	buttons = []
	
	for c in get_children():
		if c is Button: buttons.append(c as Button)
				
	var btn = buttons[0] as Button
	btn.focus_mode = Control.FOCUS_ALL


func _input(event: InputEvent) -> void:
	if pause_condition_name and Core.get(pause_condition_name) == false: return
	
	var btn = buttons[selected] as Button
	btn.grab_focus()
	
	if event.is_action_pressed("ui_accept"):
		print("sound")
		btn.emit_signal("button_down")
		
	if event.is_action_pressed("ui_down"):
		selected = selected - 1 if selected > 0 else len(buttons) - 1
		Audio.play_sound(Audio.sounds["hover"])
		
	if event.is_action_pressed("ui_up"):
		selected = selected + 1 if selected < len(buttons) - 1 else 0
		Audio.play_sound(Audio.sounds["hover"])
