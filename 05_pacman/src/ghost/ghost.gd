extends Node2D

@export var distance : int = 0 # how many corners away ghost wants to be from the player
@export var corner_direction : Vector2
@export var is_inky : bool = false
@export var scatter_distance : int = 0

var base_color : Color
var target : Vector2
var corner : Vector2
var current_path : Array[Vector2] = []
var start_pos : Vector2

enum states {CHASE, FRIGHTENED, SCATTER, DEAD}
var state : states = states.CHASE :
	set(e): 
		state = e
		modulate = get_color()

signal move(direction)

func _ready() -> void:
	Game.set_frightened_mode.connect(set_frightened_mode)
	Game.hp_lost.connect(reset)
	start_pos = Game.round_position(position)
	base_color = modulate
	reset()


func _process(_delta: float) -> void:
	#if Input.is_action_just_pressed("debug2"):
		#take_step()
				
	if state in [states.DEAD, states.FRIGHTENED]: 
		return
		
	if scatter_distance != 0:
		var d1 = position.distance_squared_to(Game.player_pos)
		var d2 = pow((scatter_distance * Game.grid_size), 2)
		state = states.CHASE if d1 > d2 else states.SCATTER


func _on_stop() -> void:
	if position == start_pos: 
		state = states.CHASE
		
	take_step()
	
	
func get_color() -> Color:
	if state == states.CHASE:
		return base_color
	elif state == states.SCATTER:
		return base_color # only for debug
	elif state == states.DEAD:
		return Color.WHITE
	else:
		return Color.GREEN


func take_step() -> void: # this is lagging propably
	if state == states.DEAD:
		target = start_pos
	elif state == states.SCATTER:
		target = corner
	elif state == states.FRIGHTENED:
		target = Game.get_possible_directions(position).pick_random()
	elif state == states.CHASE:
		if distance == 0:
			target = Game.player_pos
		elif is_inky:
			target = Game.get_inky_target()
		else:
			target = Game.find_crossroad_x_units_from(Game.player_pos, distance)
	
	current_path = Game.find_path(Game.round_position(position), target)
	
	var next_step : Vector2 
	if len(current_path) >= 1:
		next_step = current_path.front()
		current_path.pop_front()
	else:
		var near = Game.get_possible_directions(position)
		next_step = near.pick_random()
		
	var dir : Vector2 = (next_step - position).normalized()
	move.emit(dir)


func _on_area_entered(area: Area2D) -> void:
	if area.get_collision_layer_value(1):
		if state == states.FRIGHTENED:
			state = states.DEAD
		elif state in [states.CHASE, states.SCATTER]:
			Game.hp -= 1
		

func set_frightened_mode() -> void:
	var t : Timer = find_child("FrightenedTimer")
	state = states.FRIGHTENED
	
	if t != null:
		t.start()
		return
		
	t = Timer.new()
	t.name = "FrightenedTimer"
	t.wait_time = Game.frightened_time
	t.timeout.connect(func(): 
		if state == states.FRIGHTENED: state = states.CHASE
		t.queue_free()	
	)
	add_child(t)
	t.start()
	

func reset() -> void:
	base_color = modulate
	
	var t : Timer = Timer.new()
	t.wait_time = Game.initial_delay
	t.timeout.connect(take_step)
	add_child(t)
	t.start()
	
	corner = Game.get_corner(corner_direction)
	position = start_pos
