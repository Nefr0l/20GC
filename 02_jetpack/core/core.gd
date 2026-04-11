extends Node

var SpeedMultiplier : float = 1.1
var SpawnThreshold : float = 2.0

var Obstacle : PackedScene
var Score : int = 0
var cfg : ConfigFile
var high_score : int = 0

func _ready() -> void:	
	Obstacle = load("res://objects/obstacle.tscn")
	
	cfg = ConfigFile.new()
	var err = cfg.load("user://scores.cfg")
	
	if err == OK:
		high_score = cfg.get_value("player", "high_score")
	
	var spawn_timer = Timer.new()
	spawn_timer.autostart = true
	spawn_timer.wait_time = SpawnThreshold
	add_child(spawn_timer)  
	spawn_timer.timeout.connect(spawn_obstacle)
	spawn_timer.start()
	
	var score_timer = Timer.new()
	score_timer.autostart = true
	score_timer.wait_time = 0.2
	add_child(score_timer)
	score_timer.timeout.connect(add_score)
	score_timer.start()


func reset() -> void:
	get_tree().reload_current_scene()
	
	
func game_over() -> void:
	get_tree().paused = true
	if Score > high_score:
		high_score = Score
		cfg.set_value("player", "high_score", high_score)
		cfg.save("user://scores.cfg")
	Score = 0
	
	
func spawn_obstacle() -> void:
	var i = Obstacle.instantiate()
	get_tree().current_scene.add_child(i)
	SpeedMultiplier += 0.02
	
	
func add_score() -> void:
	Score+=1
	
