extends Control

func _on_player_dead() -> void:
	Core.game_over()
	show()


func _on_restart_button_down() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	hide()
