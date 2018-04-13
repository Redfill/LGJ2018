extends KinematicBody2D

export(float) var gravity = 34.3
export(float) var fallFactor = 4
export(float) var walkSpeed = 300
export(float) var runSpeed = 600
export(float) var jumpSpeed = 940

var velocity = Vector2()
var is_tethered = false
var tethered_to = Vector2()
var min_speed = 5

var whip
var cage
var vp
var sprite

func _ready():
	whip = get_node("Whip")
	whip.connect("hit_stalagtite", self, "tether")
	cage = get_parent().get_node("Cage")
	vp = get_viewport()
	sprite = get_node("AnimatedSprite")

func _physics_process(delta):
	if velocity.y > 0:
		velocity.y += gravity * fallFactor
	else:
		velocity.y += gravity

	set_movement_speed()
	if is_tethered:
		whip.rotation = whip.global_position.angle_to_point(tethered_to) + PI
	if !is_tethered && Input.is_action_just_pressed("game_whip"):
		whip.rotation = whip.get_angle_to(vp.get_mouse_position())
		whip.whip()
	velocity = move_and_slide(velocity, Vector2(0, -1), min_speed)

func set_movement_speed():
	var walk = 0
	var slides = get_slide_count()
	var collision = null
	if slides > 0:
		collision = get_slide_collision(slides - 1)
	var friction = 0.8
	if collision:
		if collision.collider.name == "TileMap":
			friction = collision.collider.collision_friction
		else:
			friction = collision.collider.friction
	if Input.is_action_pressed("game_left"):
		if is_tethered:
			walk -= walkSpeed / 16
		elif Input.is_action_pressed("game_run"):
			walk -= runSpeed
		else:
			walk -= walkSpeed
	if Input.is_action_pressed("game_right"):
		if is_tethered:
			walk += walkSpeed / 16
		elif Input.is_action_pressed("game_run"):
			walk += runSpeed
		else:
			walk += walkSpeed
	velocity.x = velocity.x * (1 - friction) + walk
	if walk < 0:
		sprite.flip_h = true
	elif walk > 0:
		sprite.flip_h = false
	if abs(walk) > 5:
		sprite.play("walking")
	else:
		sprite.stop()
	if !is_tethered:
		if is_on_floor() && Input.is_action_pressed("game_jump"):
			velocity.y -= jumpSpeed
	else:
		if Input.is_action_pressed("game_jump"):
			velocity.y -= jumpSpeed / 3
			untether()

func tether(body):
	is_tethered = true
	tethered_to = body.global_position
	min_speed = 0
	whip.get_node("Timer").stop()
	cage.activate(tethered_to)

func untether():
	is_tethered = false
	min_speed = 5
	whip._on_Timer_timeout()
	cage.deactivate()
