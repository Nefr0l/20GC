extends Node

func change_scene(scene_path : String) -> void:
	Game.unpause()
	if scene_path.contains("game"):
		Game.setup_game()

	get_tree().change_scene_to_file("res://" + scene_path + ".tscn", )
	

func reload_current_scene() -> void:
	Game.unpause()
	Game.setup_game()
	get_tree().reload_current_scene()
	hide_parent()
	
	
func hide_parent() -> void:
	var parent = get_parent()
	if parent is Control:
		parent.hide()
	
