extends Node

var gravity : Vector2 = Vector2(0, 900.0)
var paused : bool :
	set(e): 
		paused = e
		on_paused_change()
var win : bool :
	set(e): 
		win = e
		if win == true: paused = true

var checkpoint : Vector2
var player_pos : Vector2

signal on_player_death


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	setup()
	
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("debug1"):
		win = !win
	elif Input.is_action_just_pressed("debug2"):
		on_player_death.emit()


func setup() -> void:
	win = false
	paused = false
	if gravity.y < 0: gravity.y *= -1


func on_paused_change() -> void:
	get_tree().paused = paused
	
	
