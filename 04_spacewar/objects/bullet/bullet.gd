extends Area2D

var speed : float = 900
var offscreen_margin : float = 20
var belongs_to : int = 0 # player uid
var player_id : int = 0


func _process(delta: float) -> void:
	position += Vector2(speed, 0).rotated(rotation) * delta
	position = Core.clamp_position(position)
	
	if Core.is_game_over:
		queue_free()


func _on_destroy_timer_timeout() -> void:
	Core.emit_particles(position)
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.get_collision_layer_value(1) and area.get_instance_id() != belongs_to:
		Core.player_won = player_id
		area.queue_free()
		Core.emit_particles(position, Core.big_explosion_path)
		Core.game_over()
	elif area.get_collision_layer_value(2):
		Core.emit_particles(position)
		area.queue_free()
		queue_free()
	elif area.get_collision_layer_value(3):
		Core.emit_particles(position)
		queue_free()
