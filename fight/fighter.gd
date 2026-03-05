extends Node

const FightChoices := preload("res://fight/fight_choice.gd")

@export var max_hearts: int = 5

## The four possible actions for the fighter.
## Should never be anything other than four in size.
var actions: Array[Action] = [Actions.digitigrade_jab, Actions.digitigrade_jab, Actions.digitigrade_jab, Actions.digitigrade_jab]
var stored_actions: Array[Action] = [Actions.digitigrade_jab, Actions.rest]

var hearts: Array[Action] = [] #[Actions.digitigrade_jab, Actions.digitigrade_jab, Actions.rest, Actions.rest]
var status: Array[Action] = []

var healthbar

signal died()
signal hurt()
signal actions_modified(dino)

func _ready():
	hurt.connect(on_hurt)

func on_hurt():
	if hearts.size() >= max_hearts:
		died.emit()
		hearts.resize(max_hearts)

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
	
	var target
	if self == all[2]:
		target = [all[0], all[1]].pick_random()
	else:
		target = all[2]
	
	await use_action(idx, target, all)

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
	await healthbar.anim_attack(i, action)
	if action.activates_on_enter_dino():
		await anim_heart(i)
		action.on_enter_dino(self, all)

func use_action(idx: int, target, all: Array):
	var action: Action = actions[idx]
	actions[idx] = stored_actions.pick_random()
	actions_modified.emit(self)
	
	if action.is_instant():
		action.on_instant_use(self, all)
	elif not action.is_status():
		await target.attack(action, all)

func anim_heart(i: int) -> Signal:
	return healthbar.anim_activate(i)

#func apply_on_action_used(all: Array):
