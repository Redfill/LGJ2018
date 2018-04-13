extends Button


func _ready():
	self.connect("pressed", self, "clicked")
	
func clicked():
	get_tree().change_scene("res://scenes/Demo.tscn")