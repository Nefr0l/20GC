extends Node

var data : Dictionary = {
	# to adjust
	"scrolling_speed": 120.0,
	"spawn_cooldown": 2.0,
	"base_hp": 3,
	"base_fuel": 99,
	"enemy_x_speed": 150.0,
	"obstacles_per_level": 10,
	
	"objects": {
		"enemies": ["res://enemies/boat.tscn", "res://enemies/plane.tscn"],
		"fuel": "res://objects/fuel.tscn",
		"cube": "res://objects/cube.tscn",
		"bridge": "res://objects/bridge.tscn"
	},
	
	# do not touch
	"hp": 3,
	"fuel": 99,
	"score": 0,
	"high_score": 0,
	"region_pos": 0.0
}

var config : ConfigFile = ConfigFile.new()
var screen : Rect2

var enemy_timer : Timer = Timer.new()
var fuel_timer : Timer = Timer.new()
var obstacle_timer : Timer = Timer.new()
var obstacle_counter : int = 0


func begin_game() -> void:
	reload_data()
	screen = get_viewport().get_visible_rect()
	
	var err = config.load("user://scores.cfg")
	if err == OK: data["high_score"] = config.get_value("player", "high_score")
	
	enemy_timer.timeout.connect(_spawn_enemy)
	fuel_timer.timeout.connect(_spawn_fuel)
	obstacle_timer.timeout.connect(_spawn_obstacles)
	
	for t in [enemy_timer, fuel_timer, obstacle_timer]:
		t.wait_time = data["spawn_cooldown"]
		t.autostart = true
		add_child(t)
	

func _spawn_enemy() -> void:
	if not get_tree().current_scene:
		return
		
	enemy_timer.wait_time = randf_range(1, 3)
	
	var enemies = data["objects"]["enemies"]
	var n = randi_range(0, len(enemies) - 1)
	var enemy = load(enemies[n]).instantiate()
	
	enemy.position = Vector2(randi_range(100, 400), -50)
	get_tree().current_scene.add_child(enemy)
	

func _spawn_fuel() -> void:
	fuel_timer.wait_time = randf_range(1, 3)
	
	var fuel = load(data["objects"]["fuel"]).instantiate()
	fuel.position = Vector2(randi_range(100, 400), -50)
	get_tree().current_scene.add_child(fuel)
	

func _spawn_obstacles() -> void:
	obstacle_counter += 1
	
	if obstacle_counter >= data['obstacles_per_level']:
		spawn_bridge()
		obstacle_counter = 0
		return
	
	var width = randi_range(1, 5)
	var height = randi_range(8, 16)
	var y_offset = floori(data["region_pos"]) % 32
	
	var o1 : Area2D = Generator.get_boulder(width, height)
	o1.position += Vector2(32, -32 * height - y_offset)
	get_tree().current_scene.add_child(o1)
	
	var o2 : Area2D = Generator.get_boulder(width, height)
	o2.position += Vector2(screen.size.x - 32 * (width + 1), -32 * height - y_offset)
	get_tree().current_scene.add_child(o2)
	
	obstacle_timer.wait_time = height / 4
	
	
func spawn_bridge() -> void:
	var bridge = load(data["objects"]["bridge"]).instantiate() as Area2D
	bridge.position.y = -100
	get_tree().current_scene.add_child(bridge)
	

func reset() -> void:
	get_tree().reload_current_scene()
	
	 
func game_over() -> void:
	get_tree().paused = true
	
	if data["score"] > data["high_score"]:
		data["high_score"] = data["score"]
		config.set_value("player", "high_score", data["high_score"])
		config.save("user://scores.cfg")
	
	data["score"] = 0
	
	
func reload_data() -> void:
	data["hp"] = data["base_hp"]
	data["fuel"] = data["base_fuel"]
