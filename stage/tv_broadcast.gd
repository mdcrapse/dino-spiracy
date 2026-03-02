extends Node2D

func _ready():
	if Game.day == 3:
		Game.dialogue(preload("res://dialogue/day3/talk5_tv.dialogue"), "start")
	if Game.day == 2:
		Game.dialogue(preload("res://dialogue/day2/talk6_tv.dialogue"), "start")
		
	Game.day -= 1
