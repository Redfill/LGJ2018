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
	if Input.is_action_pressed("ui_left"):
		walk -= walkSpeed
	if Input.is_action_pressed("ui_right"):
		walk += walkSpeed
	velocity.x = walk
	if is_on_floor() && Input.is_action_pressed("ui_up"):
		velocity.y += -jumpSpeed
	velocity = move_and_slide(velocity, Vector2(0, -1))
