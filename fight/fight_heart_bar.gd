extends PanelContainer

const Heart := preload("res://fight/fight_heart.gd")
const HeartScene := preload("res://fight/fight_heart.tscn")

var hearts: Array[Heart] = []

@onready var hearts_ui = %Hearts

func _ready():
	hearts.resize(hearts_ui.get_child_count())
	var i := 0
	for child in hearts_ui.get_children():
		hearts[i] = child
		i += 1

func set_max_hearts(max_hearts: int):
	for c in hearts_ui.get_children():
		c.free()
	hearts.clear()
	for i in max_hearts:
		var h := HeartScene.instantiate()
		hearts_ui.add_child(h)
		hearts.append(h)

func anim_attack(idx: int, action: Action): # -> Signal:
	if idx >= 0 and idx < hearts.size():
		return hearts[idx].anim_attack(action)
	return null

func anim_activate(idx: int): # -> Signal:
	if idx >= 0 and idx < hearts.size():
		return hearts[idx].anim_activate()
	return null
