extends RigidBody2D

var identifier = "VenoAttackDefault"
export (int) var player_id = 0
export (int) var direction = 1
export (int) var projectile_speed = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	set_collision_mask_bit(2, true)
	set_collision_layer_bit(2, true)
	if player_id == 1:
		set_collision_mask_bit(1, true)
	if player_id == 2:
		set_collision_mask_bit(0, true)
	self.position.x += 40.0 * direction
	apply_impulse(Vector2(), Vector2(direction * projectile_speed, 0))



func _on_VenoAttackDefault_body_entered(body):
	get_parent().remove_child(self)
	
	if body.has_method("handle_hit") && body.id != player_id:
		body.handle_hit(self)

