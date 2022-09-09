extends ProgressBar

export (NodePath) var player = null

# Called when the node enters the scene tree for the first time.
func _process(delta):
	var p = get_node(player)
	if p != null:
		value = p.damage_factor


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
