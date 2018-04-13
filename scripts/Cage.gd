extends StaticBody2D

func activate(pos):
	get_node("CollisionPolygon2D").disabled = false
	global_position = pos

func deactivate():
	get_node("CollisionPolygon2D").disabled = true