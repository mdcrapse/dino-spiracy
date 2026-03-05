extends Node

const FightChoices := preload("res://fight/fight_choice.gd")

@export var max_hearts: int = 5

## The four possible actions for the fighter.
## Should never be anything other than four in size.
var actions: Array[Action] = [Actions.digitigrade_jab, Actions.digitigrade_jab, Actions.rest, Actions.rest]
var stored_actions: Array[Action] = []

var hearts: Array[Action] = [Actions.digitigrade_jab, Actions.digitigrade_jab, Actions.rest, Actions.rest]
var status: Array[Action] = []

func update_choices(choices: FightChoices):
	var idx := 0
	for action in actions:
		choices.show_action(idx, action)
		idx += 1

## Plays the fighter's turn given all the fighters.
func play_turn(all: Array, fight, healthbar):
	await start_phase(all, healthbar)
	await action_phase(all, fight, healthbar)
	await end_phase(all, healthbar)

func start_phase(all: Array, healthbar):
	print("starting phase")
	var i := 0
	for action in (hearts + status):
		if action.activates_on_turn_start():
			await healthbar.hearts[i].anim_activate()
			action.on_turn_start(self, all)
		i += 1

func action_phase(all: Array, fight, healthbar):
	print("action phase")
	var meta = await fight.await_character_choice(self)
	print(meta)

func end_phase(all: Array, healthbar):
	print("ending phase")
	var i := 0
	for action in (hearts + status):
		if action.activates_on_turn_end():
			healthbar.hearts[i].anim.play("activate")
			await healthbar.hearts[i].anim_activate()
			action.on_turn_end(self, all)
		i += 1

#func apply_on_action_used(all: Array):
