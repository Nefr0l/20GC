extends Camera2D

var window_size : Vector2
var position_offset : Vector2


func _ready() -> void:
	window_size = get_viewport().get_visible_rect().size
	position_offset = Vector2(window_size.x / 2, window_size.y / 2)


func _process(_delta: float) -> void:
	var kx = int(Game.player_pos.x / window_size.x)
	if Game.player_pos.x < 0: kx -= 1
	var x = kx * window_size.x
	
	var ky = int(Game.player_pos.y / window_size.y)
	if Game.player_pos.y < 0: ky -= 1
	var y = ky * window_size.y
	
	position = Vector2(x + position_offset.x, y + position_offset.y)
