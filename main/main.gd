extends Node

@onready var balloon := $Balloon

const INTRO := preload("res://dialogue/intro.dialogue")

func _ready():
	Game.dialogue = balloon
	Game.dialogue.start(INTRO, "start")
