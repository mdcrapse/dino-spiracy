extends Node

const Balloon := preload("res://dialogue/balloon/balloon.gd")
const BalloonScene := preload("res://dialogue/balloon/balloon.tscn")

#var dialogue: Balloon = null
var day: int = 0

#func _ready():
	#call_deferred("init_dialogue")

#func init_dialogue():
	#if dialogue == null:
		#dialogue = BalloonScene.instantiate()
		#get_parent().add_child(dialogue)

func dialogue(resource: DialogueResource, title: String):
	DialogueManager.show_dialogue_balloon_scene("res://dialogue/balloon/balloon.tscn", resource, title)
