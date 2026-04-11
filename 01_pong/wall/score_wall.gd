extends Node

@export var scoreToPlayer : int


func _on_area_entered(area: Area2D) -> void:
	if area.get_collision_layer_value(2):
		if scoreToPlayer == 1:
			Core.ScoreP1+=1
		elif scoreToPlayer == 2:
			Core.ScoreP2+=1
		
		Core.reset()
