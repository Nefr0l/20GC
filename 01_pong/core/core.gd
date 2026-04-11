extends Node

# Game variables - change
var Padding : int = 20
var BallSpeed : float = 40

# Helper variables - do not change
var ScoreP1 : int = 0
var ScoreP2 : int = 0

var StartY : int = 0
var BoundUp : float = 0
var BoundDown : float = 0

func _enter_tree() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	var rect = get_viewport().get_visible_rect()
	StartY = rect.size.y / 2 # half height
	
	BoundDown = rect.get_center().y + StartY - Padding - 40
	BoundUp = rect.get_center().y - StartY + Padding + 40
	
func reset() -> void:
	get_tree().reload_current_scene()
	
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("restart") and get_tree().paused == true:
		get_tree().paused = false
		ScoreP1 = 0
		ScoreP2 = 0
		reset()
