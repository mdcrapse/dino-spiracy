extends Node2D

@export var start_dialogue: DialogueResource
@export var goto_stage: String

@onready var day_1 = $Day1
@onready var day_2 = $Day2
@onready var day_3 = $Day3

func _ready():
	DialogueManager.dialogue_ended.connect(dialogue_ended)
	
	if Game.day != 1:
		day_1.free()
	if Game.day != 2:
		day_2.free()
	if Game.day != 3:
		day_3.free()
	
	if start_dialogue != null:
		Game.dialogue(start_dialogue, "start")

func dialogue_ended(d: DialogueResource):
	if d == start_dialogue and goto_stage != "":
		Game.goto_stage(load(goto_stage))
