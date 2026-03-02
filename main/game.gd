extends Node

const Balloon := preload("res://dialogue/balloon/balloon.gd")
const BalloonScene := preload("res://dialogue/balloon/balloon.tscn")

#var dialogue: Balloon = null
var day: int = 3

#func _ready():
	#call_deferred("init_dialogue")

#func init_dialogue():
	#if dialogue == null:
		#dialogue = BalloonScene.instantiate()
		#get_parent().add_child(dialogue)

func goto_stage(stage: PackedScene):
	get_tree().get_first_node_in_group("stage").queue_free()
	call_deferred("spawn_stage", stage)

func spawn_stage(stage: PackedScene):
	var s := stage.instantiate()
	add_child(s)

func dialogue(resource: DialogueResource, title: String):
	DialogueManager.show_dialogue_balloon_scene("res://dialogue/balloon/balloon.tscn", resource, title)
