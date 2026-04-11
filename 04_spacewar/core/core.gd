extends Node

var min_speed : float = 5
var max_speed : float = 400
var turn_speed : float = 200

var margin : float = 20
var player_won : int = 0
var explosion_path := "res://objects/explosion/explosion.tscn"
var big_explosion_path := "res://objects/explosion/explosion2.tscn"
var is_game_over : bool = false


func _enter_tree() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

	
func clamp_position(pos: Vector2) -> Vector2:
	var rect = get_tree().root.get_visible_rect().size
	var new_pos = pos
	
	if pos.y < -margin:
		new_pos.y = rect.y + margin
	elif pos.y > rect.y + margin:
		new_pos.y = -margin
		
	if pos.x < -margin:
		new_pos.x = rect.x + margin
	elif pos.x > rect.x + margin:
		new_pos.x = -margin
		
	return new_pos
	

func emit_particles(pos: Vector2, path: String = explosion_path):
	var particles = load(path).instantiate() as GPUParticles2D
	particles.position = pos
	get_tree().root.add_child(particles)
	particles.emitting = true
	
	
func game_over():
	print("game over")
	Audio.play_sound(Audio.sounds["explosion"], 0.4)
	Audio.stop_music()
	is_game_over = true
	Engine.time_scale = 0.1
	get_tree().paused = true
	
	
func unpause():
	Engine.time_scale = 1
	get_tree().paused = false
	is_game_over = false
	
	
func change_scene(path: String):
	get_tree().change_scene_to_file(path)

	
	
	
	
	
