extends KinematicBody2D

export(float) var gravity = 34.3
export(float) var fallFactor = 1
export(float) var walkSpeed = 300
export(float) var jumpSpeed = 940

var velocity = Vector2()

func _ready():
	pass

func _physics_process(delta):
	if velocity.y > 0:
		velocity.y += gravity * fallFactor
	else:
		velocity.y += gravity

	var walk = 0
	if Input.is_action_pressed("game_left"):
		walk -= walkSpeed
	if Input.is_action_pressed("game_right"):
		walk += walkSpeed
	velocity.x = walk
	if is_on_floor() && Input.is_action_pressed("game_jump"):
		velocity.y -= jumpSpeed
	if Input.is_action_just_pressed("game_whip"):
		var whip = get_node("Whip")
		var pointer = get_viewport().get_mouse_position() - position - get_node("Whip").position
		whip.rotation = whip.get_angle_to(get_viewport().get_mouse_position())
		whip.whip()
	velocity = move_and_slide(velocity, Vector2(0, -1))
