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

	position.x = (t1.x + t2.x) / 2
	position.y = (t1.y + t2.y) / 2
	
	var zx = (sqrt(t1.x * t1.x) + sqrt(t2.x * t2.x)) / 4000
	var zy = (sqrt(t1.y * t1.y) + sqrt(t2.y * t2.y)) / 4000
	
	var z = 0
	
	if zx > zy:
		z = zx
	if zy > zx:
		z = zy
	
	var z_min = 0.3
	var z_max = 1
	
	if z < z_min:
		z = z_min
	if z > z_max:
		z = z_max
	
	zoom.x = z * 5
	zoom.y = z * 5
