extends CharacterBody2D

@export var speed : float = 300.0
var current_dir : float = 1

var is_idle : bool = true
var in_air : bool = true

signal change_direction
signal start_moving
signal stop_moving


func _ready() -> void:
	Game.on_player_death.connect(on_player_death)
	Game.checkpoint = position


func _physics_process(delta: float) -> void:
	velocity += Game.gravity * delta

	var dir := Input.get_axis("move_left", "move_right")
	if dir: velocity.x = dir * speed
	else: velocity.x = move_toward(velocity.x, 0, speed)

	if dir * current_dir < 0:
		current_dir = dir
		change_direction.emit()
		
	if dir == 0 and not is_idle:
		is_idle = true
		stop_moving.emit()
		
	if dir != 0 and is_idle:
		is_idle = false
		start_moving.emit()
	
	move_and_slide()
	
	
func on_player_death() -> void:
	Audio.play_sound("death")
	position = Game.checkpoint
