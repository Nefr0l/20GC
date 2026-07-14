extends Node

var z : int = 100

func draw_point(position : Vector2, color : Color, timeout : float = 0):
	if position == null: return
		
	var col = CollisionShape2D.new()
	var circle = CircleShape2D.new()
	circle.radius = 8
	col.debug_color = color
	col.z_index = min(z, 999)
	z+=1
	
	col.shape = circle
	col.global_position = position
	
	add_child(col)
	
	if timeout != 0:
		var t = Timer.new()
		t.wait_time = timeout
		col.add_child(t)
		t.start()
		t.timeout.connect(func(): if col: col.queue_free())
		
