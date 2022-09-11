extends KinematicBody2D
export (int) var id = null

export (int) var speed = 500
export (int) var max_jump_speed = 1500
var jump_speed = 0
export (int) var gravity = -500

var jump_allowed = true
var double_jump_allowed = false
var velocity = Vector2()
var direction = 1
var attack_allowed = true
var damage_factor = 1;

func _ready():
	if id == 1:
		$".".set_collision_layer_bit(0, true)
		$".".set_collision_layer_bit(1, false)
		$".".set_collision_mask_bit(0, false)
		$".".set_collision_mask_bit(1, false)
		$".".set_collision_mask_bit(2, true)
	if id == 2:
		$".".set_collision_layer_bit(0, false)
		$".".set_collision_layer_bit(1, true)
		$".".set_collision_mask_bit(0, false)
		$".".set_collision_mask_bit(1, false)
		$".".set_collision_mask_bit(2, true)
		
func get_input():
	if Input.is_action_pressed(("right_%s" % id)):
		velocity.x = speed
	if Input.is_action_pressed(("left_%s" % id)):
		velocity.x = -speed
	if Input.is_action_pressed(("down_%s") % id):
		velocity.y = jump_speed
	if Input.is_action_just_pressed(("attack_default_%s") % id):
		if attack_allowed:
			$AnimatedSprite.play("attack_default")
			attack_allowed = false
			$DefaultAttackTimer.start(0.3)
			var veno_attack_default = load("./VenoAttackDefault.tscn").instance()		
			veno_attack_default.position = position
			veno_attack_default.player_id = id
			veno_attack_default.direction = direction 
			get_parent().add_child(veno_attack_default)
	if Input.is_action_just_pressed(("up_%s" % id)):
		if double_jump_allowed:
			double_jump_allowed = false
			jump_speed = max_jump_speed
		if  jump_allowed:
			jump_allowed = false
			double_jump_allowed = true
			jump_speed = max_jump_speed
		
	
	if velocity.x < 0.0:
		direction = -1
		$AnimatedSprite.scale.x = -1
	if velocity.x > 0.0:
		direction = 1
		$AnimatedSprite.scale.x = 1

func _process(delta):
	get_input()
	if damage_factor >= 100:
		get_parent().remove_child(self)

func get_id():
	return id;

func _physics_process(delta):
	if velocity.x > 0:
		velocity.x = velocity.x - velocity.x / 100 * 20;
	if velocity.x < 0:
		velocity.x = velocity.x + (velocity.x / 100 * 20) * -1;
	
	if jump_speed > 0:
		jump_speed -= 30
	else:
		jump_speed = 0
		
	var vel = velocity
	
	vel.y = -jump_speed
	vel.y -= gravity
	var collision = move_and_slide(vel, Vector2.UP);

	if is_on_floor():
		jump_allowed = true

func _on_DefaultAttackTimer_timeout():
	attack_allowed = true


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "attack_default":
		$AnimatedSprite.animation = "idle"

func handle_hit(body):
	if body.identifier == "VenoAttackDefault":
		self.damage_factor += 1;
		velocity.x = damage_factor * body.direction * 10
