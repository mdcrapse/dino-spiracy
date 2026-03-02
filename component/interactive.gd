extends Area2D

const Player := preload("res://player/player.gd")

@export var opens_dialogue: DialogueResource
@export var dialogue_title: String = "start"
var players: Array[Player] = []
@onready var hint_label = %HintLabel

signal interacted(players: Array[Player])

func _unhandled_input(event: InputEvent):
	for plr: Player in players:
		if event.is_action_released(plr.input_interact):
			interacted.emit(players)
			if opens_dialogue != null:
				Game.dialogue(opens_dialogue, dialogue_title)
			break

func _on_body_entered(plr: Player):
	players.append(plr)
	show()
	hint_label.text = plr.interact_hint

func _on_body_exited(plr: Player):
	players.erase(plr)
	if players.is_empty():
		hide()
