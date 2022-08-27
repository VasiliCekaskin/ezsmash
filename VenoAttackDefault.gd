extends RigidBody2D

export (int) var player_id = 0
export (int) var direction = 1
export (int) var projectile_speed = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	self.position.x += 40.0 * direction
	apply_impulse(Vector2(), Vector2(direction * projectile_speed, 0))
