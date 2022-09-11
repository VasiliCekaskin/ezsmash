extends Camera2D

export (NodePath) var p1_path = null
export (NodePath) var p2_path = null
	
func _process(delta):
	var p1 = get_node(p1_path)
	var p2 = get_node(p2_path)
	
	if !p1 || !p2:
		return
	
	var t1 = p1.position
	var t2 = p2.position
	
	var distance = sqrt((t1.x - t2.x) * (t1.x - t2.x))
	
	var k = distance / 1000;
	
	if k >= 0.3 && 1.5 + k < 2.2:
		zoom.x = 1.5 + k;
		zoom.y = 1.5 + k;
	
