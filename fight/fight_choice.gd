extends VBoxContainer

@export var character: String = "ron"

# Input actions
@onready var up := character + "_jump"
@onready var left := character + "_move_left"
@onready var right := character + "_move_right"
@onready var down := character + "_crouch"

## The four possible choices.
@onready var options: Array[FightOption] = [
	FightOption.new(up, %ChoiceUp, 0),
	FightOption.new(left, %ChoiceLeft, 1),
	FightOption.new(right, %ChoiceRight, 2),
	FightOption.new(down, %ChoiceDown, 3)
]

@onready var desc_label = %DescLabel

class FightOption:
	func _init(ia: String, l: Label, i: int):
		input_action = ia
		label = l
		text = label.text
		idx = i
	
	var text: String :
		set(value):
			text = value
			label.text = value
	var desc: String
	var input_action: String
	var focused: bool
	var label: Label
	var idx: int
	var meta: Variant

## Invoked when a choice has been chosen.
signal chose(meta: Variant)

func _input(event: InputEvent):
	for option in options:
		if event.is_action_pressed(option.input_action):
			if option.focused:
				unfocus_options()
				chose.emit(option.meta)
			else:
				focus_option(option)
			break

func show_action(idx: int, action: Action):
	var desc := action.type_name() + "\n" + action.desc
	var meta := {idx = idx, action = action}
	show_choice(idx, action.name, desc, meta)

func show_choice(idx: int, text: String, desc: String, meta: Variant = null):
	if idx >= 0 && idx < options.size():
		var option := options[idx]
		option.text = text
		option.label.text = text
		option.desc = desc
		option.meta = meta

func focus_option(option: FightOption):
	unfocus_options()
	option.focused = true
	option.label.modulate = Color.RED
	desc_label.text = option.desc

func unfocus_options():
	desc_label.text = ". . ."
	for option in options:
		option.focused = false
		option.label.modulate = Color.WHITE
