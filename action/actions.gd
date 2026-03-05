class_name Actions

const Action := preload("res://action/action.gd")
const ActionType := Action.Type
#const Fighter := preload("res://fight/fighter.gd")

class Rest extends Action:
	func _init():
		name = "Rest"
		type = ActionType.SPECIAL
		desc = "Replaces action with a new action."
		texture = preload("res://character/fisherman_normal.png")

class DigitigradeJab extends Action:
	func _init():
		name = "Digitigrade Jab"
		type = ActionType.SPECIAL
		desc = "Every action used is replaced with a rest action."
		texture = preload("res://character/fisherman_normal.png")
	
	func on_turn_start(dino, all: Array):
		print("on turn start!")
	
	func on_turn_end(dino, all: Array):
		print("on turn end!")
	
	func on_enter_dino(dino, all: Array):
		print("entered dino!")
	
	#func reacts_on_action_used(dino: Fighter, all: Array, action: Action) -> bool:
		#return action is not Rest
	#
	#func on_action_used(dino: Fighter, all: Array, action: Action, action_idx: int):
		#dino.actions[action_idx] = Actions.cards.rest

static var digitigrade_jab := DigitigradeJab.new()
static var rest := Rest.new()

# ## Dictionary of all actions in the game.
#static var cards: Dictionary[String, Action] = {
	#digitigrade_jab = DigitigradeJab.new(),
	#rest = Rest.new(),
#}

static func action(name: String, type: ActionType, desc: String, texture: Texture2D) -> Action:
	var a := Action.new()
	a.name = name
	a.type = type
	a.desc = desc
	a.texture = texture
	return a
