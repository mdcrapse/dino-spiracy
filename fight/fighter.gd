extends Node

@export var max_hearts: int = 5

## The four possible actions for the fighter.
## Should never be anything other than four in size.
var actions: Array[Action] = []
var stored_actions: Array[Action] = []

var hearts: Array[Action] = []
var status: Array[Action] = []

## Plays the fighter's turn given all the fighters.
func play_turn(all: Array, fight):
	start_phase(all, fight)
	action_phase(all, fight)
	end_phase(all, fight)

func start_phase(all: Array, fight):
	var i := 0
	for action in (hearts + status):
		if action.activates_on_turn_start():
			await fight.anim_heart_activate(i)
			action.on_turn_start(self, all)
		i += 1

func action_phase(all: Array, fight):
	pass

func end_phase(all: Array, fight):
	var i := 0
	for action in (hearts + status):
		if action.activates_on_turn_end():
			await fight.anim_heart_activate(i)
			action.on_turn_end(self, all)
		i += 1
