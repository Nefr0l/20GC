extends Label

var scoreString = "0 : 0"

func _enter_tree() -> void:
	scoreString = str(Core.ScoreP1) + " : " + str(Core.ScoreP2)
	text = scoreString
	

func _process(delta: float) -> void:
	if Core.ScoreP1 >= 3:
		text = "P1 Won (press enter to restart)"
		get_tree().paused = true
		return
	elif Core.ScoreP2 >= 3:
		text = "P2 Won (press enter to restart)"
		get_tree().paused = true
		return
	
	scoreString = str(Core.ScoreP1) + " : " + str(Core.ScoreP2)
	text = scoreString
	
	
