extends Node2D

var ball_size
var ball_speed = 160
var ball_jump = 1024

func _on_ground(ball):
	#print("Ist es auf dem Boden?")
	print(ball.get_colliding_bodies())
	return (ball.get_colliding_bodies().size() > 0)

func _process(delta):
	var ball = get_node("Player_Layer/ball")
	var ball_velocity = ball.get_linear_velocity()
	var ball_vel = Vector2(0,0)
	if (Input.is_action_pressed("move_right")):
		ball_vel.x += ball_speed * delta
		ball.set_linear_velocity(ball_velocity+ball_vel)
	if (Input.is_action_pressed("move_left")):
		ball_vel.x += -ball_speed * delta
		ball.set_linear_velocity(ball_velocity+ball_vel)
	if (_on_ground(ball)):
		#print("Ist Auf dem Boden")
		if (Input.is_action_pressed("jump")):
			ball_vel.y += -ball_jump * delta
			ball.set_linear_velocity(ball_velocity+ball_vel)
	

func _ready():
	#ball_size = get_node("CanvasLayer1/Player_Layer/ball/Sprite").get_texture().get_size()
	set_process(true)
