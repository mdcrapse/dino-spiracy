extends MarginContainer

const Heart := preload("res://fight/fight_heart.gd")
const HeartScene := preload("res://fight/fight_heart.tscn")

var status: Array[Heart] = []

@onready var grid = %Grid

func anim_new_status(action: Action) -> Signal:
	var s: Heart = HeartScene.instantiate()
	grid.add_child(s)
	status.append(s)
	return s.anim_attack(action)

func anim_activate_recent(): # -> Signal:
	if not status.is_empty():
		return status.back().anim_activate()
	return null

func anim_activate(idx: int): # -> Signal:
	if idx >= 0 and idx < status.size():
		return status[idx].anim_activate()
	return null
