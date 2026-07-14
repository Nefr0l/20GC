extends Node

@export var speed : int = 100
@export var is_player : bool = false

var parent : Area2D
var collids : Dictionary[Vector2, bool] = {Vector2.UP: 0, Vector2.RIGHT: 0, Vector2.DOWN: 0, Vector2.LEFT: 0}
var last_position : Vector2
var current_dir := Vector2.ZERO
var future_dir := Vector2.ZERO

signal on_stop



func _ready() -> void:
	parent = get_parent() as Area2D
	last_position = Game.round_position(parent.position)
	parent.position = last_position
	if is_player: Game.hp_lost.connect(reset)
	
	
func _process(delta: float) -> void:
	if current_dir == Vector2.ZERO: return
		
	parent.position += current_dir * speed * delta
	
	if is_player: parent.get_child(0).rotation = current_dir.angle()
	
	if facing_wall(): 
		stop()
		future_dir = Vector2.ZERO
	elif on_crossroad(): 
		stop()
		
		
func move(dir : Vector2):
	future_dir = dir
	if current_dir == Vector2.ZERO: 
		current_dir = dir
		
	

func stop():	
	if current_dir != future_dir or facing_wall() or not is_player:
		last_position = Game.round_position(parent.position)
		parent.position = last_position
		on_stop.emit()
		
	if is_player: Game.player_collids = collids
	
	if parent.position.x > 0 and parent.position.x < Game.window_width: 
		current_dir = future_dir
		
		
func reset():
	current_dir = Vector2.ZERO
	future_dir = Vector2.ZERO
			

func add_collider(body: Node2D, dir: Vector2):
	if body is TileMapLayer: collids[dir] = true;
	

func remove_collider(body: Node2D, dir: Vector2):
	if body is TileMapLayer: collids[dir] = false;
	
	
func facing_wall() -> bool:
	return collids.has(current_dir) and collids[current_dir]
	

func on_crossroad() -> bool:
	if last_position == Game.round_position(parent.position): return false
	
	if current_dir in [Vector2.UP, Vector2.DOWN]:
		return not(collids[Vector2.LEFT] and collids[Vector2.RIGHT])
	elif current_dir in [Vector2.LEFT, Vector2.RIGHT]:
		return not(collids[Vector2.UP] and collids[Vector2.DOWN])
	else:	
		return false
		
		
