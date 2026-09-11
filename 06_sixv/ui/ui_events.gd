extends Node

func change_scene(scene_path : String) -> void:
	if scene_path.contains("game"): 
		Game.setup()
		
	Audio.play_music_on_scene_change(scene_path)
	get_tree().change_scene_to_file("res://" + scene_path + ".tscn", )
	

func reload_current_scene() -> void:
	Game.setup()
	get_tree().reload_current_scene()
	hide_parent()
	
	
func hide_parent() -> void:
	var parent = get_parent()
	if parent is Control:
		parent.hide()
		

func toggle_pause() -> void:
	Game.paused = !Game.paused
