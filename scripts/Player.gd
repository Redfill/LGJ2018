extends KinematicBody2D

export(float) var gravity = 9.8
export(float) var walkSpeed = 200
export(float) var jumpHeight = 300

var velocity = Vector2()

func _ready():
	pass

func _physics_process(delta):
	velocity.y += gravity
	var walk = 0
	
	if Input.is_action_pressed("ui_left"):
		walk -= walkSpeed
	if Input.is_action_pressed("ui_right"):
		walk += walkSpeed
	velocity.x = walk
	if is_on_floor() && Input.is_action_pressed("ui_up"):
		velocity.y += -jumpHeight
	velocity = move_and_slide(velocity, Vector2(0, -1))
