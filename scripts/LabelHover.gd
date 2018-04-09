extends Label

export var ActionName = ""

signal menu_item_pressed

func _ready():
	connect("mouse_entered", self, "makeGreen")
	connect("mouse_exited", self, "reverseGreen")

func makeGreen():
	add_color_override("font_color", Color(0, 1, 0, 1))

func reverseGreen():
	add_color_override("font_color", Color(0, 0.5, 0, 1))

func _input(event):
	if event is InputEventMouseButton:
		emit_signal("menu_item_pressed", [ActionName])
