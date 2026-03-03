extends Node2D

func _ready():
	if Game.day == 3:
		Game.dialogue(preload("res://dialogue/day3/talk5_tv.dialogue"), "start")
	if Game.day == 2:
		Game.dialogue(preload("res://dialogue/day2/talk6_tv.dialogue"), "start")
		
	Game.day -= 1
	
	DialogueManager.dialogue_ended.connect(dialogue_ended)

func dialogue_ended(d: DialogueResource):
	Game.goto_stage(load("res://stage/inn.tscn"))
