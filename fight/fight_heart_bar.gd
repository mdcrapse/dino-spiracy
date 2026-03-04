extends PanelContainer

const Heart := preload("res://fight/fight_heart.gd")

var hearts: Array[Heart] = []

@onready var hearts_ui = %Hearts

func _ready():
	hearts.resize(hearts_ui.get_child_count())
	var i := 0
	for child in hearts_ui.get_children():
		hearts[i] = child
		i += 1
