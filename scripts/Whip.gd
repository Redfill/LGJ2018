extends KinematicBody2D

func _ready():
	pass

func _on_Timer_timeout():
	visible = false
	get_node("CollisionShape2D").disabled = true
	rotation = 0

func whip():
	if !visible:
		get_node("Timer").start()
		visible = true
		get_node("CollisionShape2D").disabled = false
