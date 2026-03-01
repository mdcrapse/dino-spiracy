extends VBoxContainer

@export var character: String = "ron"

@onready var up: String = character + "_jump"
@onready var left: String = character + "_move_left"
@onready var right: String = character + "_move_right"
@onready var down: String = character + "_crouch"

@onready var choices: Dictionary[String, Label] = {}

## Invoked when a choice has been chosen.
signal chose(option: String)

func _ready():
	choices[up] = %ChoiceUp
	choices[left] = %ChoiceLeft
	choices[right] = %ChoiceRight
	choices[down] = %ChoiceDown

func _input(event: InputEvent):
	for action: String in choices:
		if event.is_action_pressed(action):
			focus_choice(choices[action])
			chose.emit(choices[action].text)
			print("chose:", choices[action].text)

func focus_choice(choice: Label):
	unfocus_choices()
	choice.modulate = Color.RED

func unfocus_choices():
	for choice: Label in choices.values():
		choice.modulate = Color.WHITE
