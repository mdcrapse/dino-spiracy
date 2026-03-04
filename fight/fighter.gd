extends Node

@export var max_hearts: int = 5

## The four possible actions for the fighter.
## Should never be anything other than four in size.
var actions: Array[Action] = [Actions.digitigrade_jab, Actions.digitigrade_jab, Actions.rest, Actions.rest]
var stored_actions: Array[Action] = []

var hearts: Array[Action] = [Actions.digitigrade_jab, Actions.digitigrade_jab, Actions.rest, Actions.rest]
var status: Array[Action] = []

## Plays the fighter's turn given all the fighters.
func play_turn(all: Array, healthbar):
	await start_phase(all, healthbar)
	action_phase(all, healthbar)
	await end_phase(all, healthbar)

func start_phase(all: Array, healthbar):
	print("starting phase")
	var i := 0
	for action in (hearts + status):
		if action.activates_on_turn_start():
			healthbar.hearts[i].anim.play("activate")
			await healthbar.hearts[i].anim.animation_finished
			action.on_turn_start(self, all)
		i += 1

func action_phase(all: Array, healthbar):
	print("action phase")

func end_phase(all: Array, healthbar):
	print("ending phase")
	var i := 0
	for action in (hearts + status):
		if action.activates_on_turn_end():
			healthbar.hearts[i].anim.play("activate")
			await healthbar.hearts[i].anim.animation_finished
			action.on_turn_end(self, all)
		i += 1

#func apply_on_action_used(all: Array):
