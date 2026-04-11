extends Label


func _process(delta: float) -> void:
	text = "High score: " + str(Core.high_score)
