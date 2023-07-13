extends HBoxContainer

var life_icon = preload("res://art/playerGrey_life.png")
# Called when the node enters the scene tree for the first time.
func update_lives(value):
	for i in get_child_count():
		get_child(i).texture = life_icon
		get_child(i).visible = value > i
