extends Node2D

var respawn_position_1 = Vector2()
var respawn_position_2 = Vector2()

func _ready():
	var p1 = get_node("Player1")
	if p1 != null:
		respawn_position_1 = p1.position
	var p2 = get_node("Player2")
	if p2 != null:
		respawn_position_2 = p2.position


func _process(delta):
	var death_floor = get_node("DeathFloor")
	var p1 = get_node("Player1")
	var p2 = get_node("Player2")
	
	if p1 != null && p1.position.y >= death_floor.position.y:
		p1.position = respawn_position_1
		
	if p2 != null && p2.position.y >= death_floor.position.y:
		p2.position = respawn_position_2
	
