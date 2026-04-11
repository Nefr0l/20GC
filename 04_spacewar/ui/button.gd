extends Button

@export var action : actions
@export var parameter : String


func _ready() -> void:
	button_down.connect(btn_down)

	
func btn_down() -> void:
	Audio.play_sound(Audio.sounds["select"])
	Core.unpause()
	
	if parameter and parameter.contains("game"):
		Audio.play_music(Audio.musics["game"])
	elif parameter and parameter.contains("menu"):
		Audio.play_music(Audio.musics["menu"], 0.3)
	
	if action == actions.quit:
		get_tree().quit()
	elif action == actions.reload_scene:
		get_tree().reload_current_scene()
	elif action == actions.change_scene:
		Core.change_scene("res://" + parameter + ".tscn", )
	elif action == actions.unpause:
		Core.unpause()
	
	
enum actions {
	change_scene,
	reload_scene,
	quit,
	unpause
}
