extends KinematicBody2D

const GRAVITY = 512
const BALL_ROLL = 128
const BALL_JUMP = -256

var velocity = Vector2()

signal move
var camera

func _ready():
	set_fixed_process(true)

func _on_ground():
	return (test_move(Vector2(0,1)))

#func is_moving():
#	return Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right")

func _fixed_process(delta):
	velocity.y += delta * GRAVITY
	if(_on_ground()):
		if (Input.is_action_pressed("move_left")):
			velocity.x = -BALL_ROLL
		elif (Input.is_action_pressed("move_right")):
			velocity.x =  BALL_ROLL
		else:
			velocity.x = 0
		if (Input.is_action_pressed("jump")):
			print("SPRING!!!")
			velocity.y = BALL_JUMP
	else:
		if (Input.is_action_pressed("move_left")):
			velocity.x = (velocity.x * delta) - BALL_ROLL / 2
		elif (Input.is_action_pressed("move_right")):
			velocity.x = (velocity.x * delta) + BALL_ROLL / 2
	var motion = velocity * delta
	motion = move(motion)
	if (is_colliding()):
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
	move(motion)
	emit_signal("move")



