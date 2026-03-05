extends Control

const FightChoice := preload("res://fight/fight_choice.gd")
const Fighter := preload("res://fight/fighter.gd")

@onready var fight_log := %FightLog

@onready var syd_panel := %SydFightPanel
@onready var syd_choices: FightChoice = syd_panel.choices

@onready var ron_panel := %RonFightPanel
@onready var ron_choices: FightChoice = ron_panel.choices

@onready var ron := $Ron
@onready var syd := $Syd
@onready var all := [ron, syd]

func _ready():
	ron.healthbar = ron_panel.healthbar
	syd.healthbar = syd_panel.healthbar
	
	ron.update_choices(ron_choices)
	syd.update_choices(syd_choices)
	
	while true:
		await ron.play_turn(all, self)
		await syd.play_turn(all, self)

func await_character_choice(character: Fighter) -> Signal:
	if character == ron:
		ron_choices.enable()
		return ron_choices.chose
	else: #elif character == syd:
		syd_choices.enable()
		return syd_choices.chose

func _on_ron_hurt():
	ron_panel.anim_hurt()

func _on_syd_hurt():
	syd_panel.anim_hurt()
