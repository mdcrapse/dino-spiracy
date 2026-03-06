extends Control

const FightChoice := preload("res://fight/fight_choice.gd")
const HURT_RANGE: float = 10.0

@export var normal: Texture2D
@export var hurting: Texture2D

var hurt_anim: float = 0.0
var time: float = 0.0

@onready var choices: FightChoice = %FightChoice
@onready var healthbar := %FightHealthBar
@onready var statusbar = %FightStatusBar
@onready var panel := $PanelContainer
@onready var portrait = %Portrait

func anim_hurt():
	hurt_anim = 1.0

func _process(delta):
	hurt_anim = max(hurt_anim - delta, 0)
	panel.modulate = Color.WHITE - Color(0, 1, 1) * hurt_anim
	panel.position.x = hurt_anim * HURT_RANGE * sin(hurt_anim * PI * 16)
	portrait.texture = normal if hurt_anim == 0 else hurting
