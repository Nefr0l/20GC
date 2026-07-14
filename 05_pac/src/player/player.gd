extends Area2D

var starting_pos : Vector2

signal move(direction)

func _ready() -> void:
	starting_pos = Game.round_position(position)
	Game.hp_lost.connect(_on_hp_lost)


func _process(_delta: float) -> void:	
	Game.player_pos = position
	
	if Input.is_action_pressed("move_up"):
		move.emit(Vector2.UP)
	elif Input.is_action_pressed("move_right"):
		move.emit(Vector2.RIGHT)
	elif Input.is_action_pressed("move_down"):
		move.emit(Vector2.DOWN)
	elif Input.is_action_pressed("move_left"):
		move.emit(Vector2.LEFT)
		
	#if Input.is_action_just_pressed("debug1"):
		#Game.hp = 9999
		
		
func _on_hp_lost() -> void:	
	position = starting_pos
	
	if Game.hp <= 0: return
	
	Game.pause()
	var t : Timer = Timer.new()
	t.wait_time = 1
	t.timeout.connect(Game.unpause)
	Game.add_child(t)
	t.start()
	
	
