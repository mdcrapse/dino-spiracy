extends Control

const FightChoice := preload("res://fight/fight_choice.gd")
const HURT_RANGE: float = 5.0

var hurt_anim: float = 0.0
var time: float = 0.0

@onready var choices: FightChoice = %FightChoice
@onready var healthbar := %FightHealthBar
@onready var panel := $PanelContainer

func anim_hurt():
	hurt_anim = 1.0

func _process(delta):
	hurt_anim = max(hurt_anim - delta, 0)
	panel.position.x = hurt_anim * HURT_RANGE * sin(hurt_anim * PI * 16)
