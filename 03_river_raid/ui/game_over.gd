extends Control


func _process(_delta: float) -> void:
	if Core.data["hp"] <= 0 or Core.data["fuel"] < 0:
		Core.game_over()
		show()


func _on_restart_button_down() -> void:
	hide()
	Core.reload_data()
	get_tree().paused = false
	get_tree().reload_current_scene()
	


func _on_return_button_down() -> void:
	Core.reload_data()
	get_tree().change_scene_to_file("res://core/menu.tscn")
