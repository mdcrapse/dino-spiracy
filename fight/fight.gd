extends Control

const FightChoice := preload("res://fight/fight_choice.gd")
const Fighter := preload("res://fight/fighter.gd")

@onready var fight_log := %FightLog
@onready var ron_health = $SafeMargin/Control/SydFightPanel/MarginContainer/VBoxContainer/Control/Health
@onready var syd_health = $SafeMargin/Control/RonFightPanel/MarginContainer/VBoxContainer/Control/Health
@onready var transition = $Transition
@onready var game_over = $Transition/GameOver
@onready var ko = $Transition/KO

@onready var syd_panel := %SydFightPanel
@onready var syd_choices: FightChoice = syd_panel.choices

@onready var ron_panel := %RonFightPanel
@onready var ron_choices: FightChoice = ron_panel.choices

@onready var ron := $Ron
@onready var syd := $Syd
@onready var all := [ron, syd]

func _ready():
	#syd_choices.show_choice(0, "Chomp", "Basic Attack\nDeals one heart of damage.", "Chomper")
	#syd_choices.show_choice(1, "Digitigrade Jab", "Special Attack\nEvery action used is replaced with a rest action.", "Special")
	#syd_choices.show_choice(2, "Chomp", "Basic Attack\nDeals one heart of damage.", "Chomper")
	#syd_choices.show_choice(3, "Chomp", "Basic Attack\nDeals one heart of damage.", "Chomper")
#
	#ron_choices.show_choice(0, "Chomp", "Basic Attack\nDeals one heart of damage.", "Chomper")
	#ron_choices.show_choice(1, "Digitigrade Jab", "Special Attack\nEvery action used is replaced with a rest action.", "Special")
	#ron_choices.show_choice(2, "Chomp", "Basic Attack\nDeals one heart of damage.", "Chomper")
	#ron_choices.show_choice(3, "Chomp", "Basic Attack\nDeals one heart of damage.", "Chomper")
	
	ron.update_choices(ron_choices)
	syd.update_choices(syd_choices)
	
	await ron.play_turn(all, self, ron_panel.healthbar)
	await syd.play_turn(all, self, syd_panel.healthbar)

func _on_syd_fight_choice_chose(meta):
	print("meta", meta)

func _on_ron_fight_choice_chose(meta):
	print("meta", meta)

func await_character_choice(character: Fighter) -> Signal:
	if character == ron:
		return ron_choices.chose
	else: #elif character == syd:
		return syd_choices.chose
