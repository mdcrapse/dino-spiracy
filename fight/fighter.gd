extends Node

const FightChoices := preload("res://fight/fight_choice.gd")

@export var max_hearts: int = 5

## The four possible actions for the fighter.
## Should never be anything other than four in size.
var actions: Array[Action] = [Actions.digitigrade_jab, Actions.digitigrade_jab, Actions.rest, Actions.rest]
var stored_actions: Array[Action] = []

var hearts: Array[Action] = [] #[Actions.digitigrade_jab, Actions.digitigrade_jab, Actions.rest, Actions.rest]
var status: Array[Action] = []

var healthbar

signal hurt()

func update_choices(choices: FightChoices):
	var idx := 0
	for action in actions:
		choices.show_action(idx, action)
		idx += 1

## Plays the fighter's turn given all the fighters.
func play_turn(all: Array, fight):
	await start_phase(all)
	await action_phase(all, fight)
	await end_phase(all)

func start_phase(all: Array):
	var i := 0
	for action in (hearts + status):
		if action.activates_on_turn_start():
			await anim_heart(i)
			action.on_turn_start(self, all)
		i += 1

func action_phase(all: Array, fight):
	var meta = await fight.await_character_choice(self)
	var idx: int = meta.idx
	var action: Action = meta.action
	
	var target = all[0] if all[0] != self else all[1]
	
	if action.type == Action.Type.INSTANT:
		action.on_instant_use(self, all)
	elif not action.is_status():
		await target.attack(action, all)

func end_phase(all: Array):
	var i := 0
	for action in (hearts + status):
		if action.activates_on_turn_end():
			await anim_heart(i)
			action.on_turn_end(self, all)
		i += 1

func attack(action: Action, all: Array):
	hurt.emit()
	hearts.append(action)
	var i := hearts.size()-1
	await healthbar.hearts[i].anim_attack(action)
	if action.activates_on_enter_dino():
		await anim_heart(i)
		action.on_enter_dino(self, all)

func anim_heart(i: int) -> Signal:
	return healthbar.hearts[i].anim_activate()

#func apply_on_action_used(all: Array):
