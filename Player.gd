extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	
	if velocity.x < 0.0:
		get_node("SpriteSheet").scale.x = -1
	if velocity.x > 0.0:
		get_node("SpriteSheet").scale.x = 1

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity);
	move_and_collide(Vector2(0.0, speed))
	
