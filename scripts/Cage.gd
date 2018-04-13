extends StaticBody2D

export(float) var height
export(float) var radius
export(Vector2) var translate = Vector2()

func _ready():
	var poly = CollisionPolygon2D.new()
	poly.set_build_mode(CollisionPolygon2D.BUILD_SEGMENTS)
	var vertices = calculate_capsule()
	poly.set_polygon(vertices)
	poly.set_name("CollisionPolygon2D")
	poly.translate(translate)
	add_child(poly)

func activate(pos):
	get_node("CollisionPolygon2D").disabled = false
	global_position = pos

func deactivate():
	get_node("CollisionPolygon2D").disabled = true

func calculate_capsule():
	var vertices = PoolVector2Array([])
	var ofs = Vector2()
	for i in range(0, 24):
		if 6 < i && i <= 18:
			ofs = Vector2(0, -height * 0.5)
		else:
			ofs = Vector2(0, height * 0.5)

		vertices.append(Vector2(sin(i * PI * 2 / 24), cos(i * PI * 2 / 24)) * radius + ofs)
		if i == 6 || i == 18:
			vertices.append(Vector2(sin(i * PI * 2 / 24), cos(i * PI * 2 / 24)) * radius - ofs)
	return vertices
