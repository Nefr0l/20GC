extends Node

var start_hp : int = 3
var initial_delay : int = 3
var frightened_time : float = 6

var hp : int :
	set(e):
		hp = e
		hp_lost.emit()
		if hp <= 0: game_over.emit()
var points : int
var total_points : int

var points_label_text : String : 
	get: return str(points) + "/" + str(total_points)
var is_hp_zero: bool:
	get: return hp <= 0
var is_win : bool:
	get: return points >= total_points

var window_width : int
var grid_size := 32
var grid_offset := 32

var tilemap : TileMapLayer
var nodes : Array[Vector2]
var walls : Array[Vector2]
var floors : Array[Vector2i]
var power_pellets : Array[Vector2i]

var player_collids : Dictionary = {Vector2.UP: 0, Vector2.RIGHT: 0, Vector2.DOWN: 0, Vector2.LEFT: 0}
var player_pos : Vector2
var blinky_pos : Vector2

signal game_over
@warning_ignore("unused_signal")
signal set_frightened_mode
signal hp_lost

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	setup_game()
	game_over.connect(pause)
	window_width = get_tree().root.get_visible_rect().size.x as int
	
	
func setup_game() -> void:
	points = 0
	total_points = 0
	hp = start_hp
	
	
func pause() -> void:
	get_tree().paused = true
	

func unpause() -> void:
	get_tree().paused = false
	

func round_position(pos : Vector2) -> Vector2:
	var new_pos : Vector2 = Vector2(pos.x, pos.y)
	if pos.x < 0: new_pos.x = window_width
	elif pos.x > window_width: new_pos.x = 0
	
	return new_pos.snapped(Vector2(grid_size, grid_size));		


func find_crossroad_x_units_from(from : Vector2, x : int) -> Vector2:
	var vector = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * x * Game.grid_size
	var pos = from + vector
	return find_closest_node(pos)

	
func get_inky_target() -> Vector2:
	var u : Vector2 = (player_pos - blinky_pos) * 2
	var target = find_closest_node(u)
	return target
	

func find_closest_node(target: Vector2) -> Vector2:
	if nodes.is_empty(): return Vector2.ZERO
	
	var nodes_duplicate = nodes.duplicate()
	nodes_duplicate.sort_custom(func(a, b): 
		return target.distance_squared_to(a) < target.distance_squared_to(b)
	)
	
	return nodes_duplicate[0]


func get_possible_directions(pos : Vector2, node_array : Array[Vector2] = nodes) -> Array[Vector2]:
	var closest = {Vector2.UP: null, Vector2.DOWN: null, Vector2.LEFT: null, Vector2.RIGHT: null}
	
	# 1. Najbliższe węzły
	for e in node_array:
		if e == pos: continue

		var d = (e - pos)
		var dir = d.normalized()
		
		if dir in closest.keys():
			if not(closest[dir]) or d.length() < closest[dir].distance_to(pos):
				closest[dir] = e

	# 2. Sprawdzamy blokady przez ściany
	var correct_dirs : Array[Vector2] = []
	
	for dir in closest:
		var node = closest[dir]
		if not node: continue
		
		var blocked = false
		for w in walls:
			if dir == Vector2.UP and w.x == pos.x and w.y < pos.y and w.y > node.y: blocked = true
			elif dir == Vector2.DOWN and w.x == pos.x and w.y > pos.y and w.y < node.y: blocked = true
			elif dir == Vector2.LEFT and w.y == pos.y and w.x < pos.x and w.x > node.x: blocked = true
			elif dir == Vector2.RIGHT and w.y == pos.y and w.x > pos.x and w.x < node.x: blocked = true
			if blocked: break
			
		if not blocked:
			correct_dirs.append(node)
			
	return correct_dirs


func find_path(from : Vector2, to : Vector2) -> Array[Vector2]:
	from = round_position(from)
	to = round_position(to)
	
	var N = nodes.duplicate()
	N.append(to)
	N.append(from)
	
	var path : Array[Vector2]
	var Distances : Dictionary[Vector2, float]
	var Prev : Dictionary[Vector2, Vector2]
	var Q : Array[Vector2]
	
	for n in N:
		Distances[n] = INF
		Q.append(n)
	Distances[from] = 0.0
	
	while not Q.is_empty():
		var c = get_closest(Q, Distances)
		if c == Vector2.INF: break
		Q.erase(c)
		
		if c == to: break
		
		for n in get_possible_directions(c, N):
			var alt = Distances[c] + c.distance_to(n)
			if alt < Distances[n]:
				Distances[n] = alt
				Prev[n] = c
	
	if to != from and not Prev.has(to): 
		print("nah")
		return []
	
	var u = to
	while u != from:
		path.append(u)
		if not Prev.has(u):
			
			return []
		u = Prev[u]
	
	path.reverse()
	
	return path


func get_closest(nodes_temp : Array[Vector2], distances : Dictionary[Vector2, float]) -> Vector2:
	var smallest_dist = INF
	var vector = Vector2.INF
	
	for n in nodes_temp:
		if distances[n] < smallest_dist:
			smallest_dist = distances[n]
			vector = n
			
	return vector
	
	
func get_corner(direction : Vector2) -> Vector2:
	var corner = Vector2.ZERO
	
	for c in nodes:
		if c * direction >= Vector2(0,0) and abs(c) > corner:
			corner = c
	
	return corner
	
