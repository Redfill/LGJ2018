extends Camera2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var player = get_node("Demo/player")

func _(delta):
	var ppos = player.get_pos()
	Position2D = ppos
	pass
