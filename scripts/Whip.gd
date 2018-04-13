extends Area2D

signal hit_stalagtite(object)

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

func _on_Whip_body_entered(body):
	if body.is_in_group("stalagtites"):
		emit_signal("hit_stalagtite", body)
