extends Node

@onready var balloon := $Balloon

const INTRO := preload("res://dialogue/intro.dialogue")

func _ready():
	balloon.start(INTRO, "start")
	#DialogueManager.show_dialogue_balloon(INTRO, "start")
