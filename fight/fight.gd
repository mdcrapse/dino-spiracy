extends Control

const FightChoice := preload("res://fight/fight_choice.gd")
const Fighter := preload("res://fight/fighter.gd")
const HURT_RANGE: float = 32.0

var enemy_hurt_anim: float = 0.0

@onready var anim = $Anim
@onready var turn_indicator = %TurnIndicator

@onready var incoming := %NextAttackPanel
@onready var enemy_portrait = %EnemyPortrait
@onready var enemy_healthbar = %EnemyHealthBar

@onready var fight_log := %FightLog

@onready var syd_panel := %SydFightPanel
@onready var syd_choices: FightChoice = syd_panel.choices

@onready var ron_panel := %RonFightPanel
@onready var ron_choices: FightChoice = ron_panel.choices

@onready var ron := $Ron
@onready var syd := $Syd
@onready var enemy = $Enemy
@onready var all := [ron, syd, enemy]

signal enemy_chose(meta)

func _ready():
	ron.healthbar = ron_panel.healthbar
	ron.healthbar.set_max_hearts(ron.max_hearts)
	update_choices(ron, ron_choices)
	
	syd.healthbar = syd_panel.healthbar
	syd.healthbar.set_max_hearts(syd.max_hearts)
	update_choices(syd, syd_choices)
	
	enemy.healthbar = enemy_healthbar
	enemy.healthbar.set_max_hearts(enemy.max_hearts)
	incoming.set_action_immediate(enemy.actions[0])
	
	while true:
		await anim_turn_indicator("Player's Turn")
		await ron.play_turn(all, self)
		await syd.play_turn(all, self)
		await anim_turn_indicator("Enemy's Turn")
		await enemy.play_turn(all, self)

func _process(delta):
	enemy_hurt_anim = max(enemy_hurt_anim - delta, 0)
	enemy_portrait.modulate = Color.WHITE - Color(0, 1, 1) * enemy_hurt_anim
	enemy_portrait.position.x = enemy_hurt_anim * HURT_RANGE * sin(enemy_hurt_anim * PI * 16)

func anim_turn_indicator(team: String) -> Signal:
	turn_indicator.text = team
	anim.play("indicate_turn")
	return anim.animation_finished

func await_character_choice(character: Fighter) -> Signal:
	if character == ron:
		ron_choices.enable()
		return ron_choices.chose
	elif character == syd:
		syd_choices.enable()
		return syd_choices.chose
	else: #elif character == enemy:
		get_tree().create_timer(2).timeout.connect(get_enemy_attack)
		return enemy_chose

func get_enemy_attack():
	enemy_chose.emit({idx = 0, action = enemy.actions[0]})

func _on_ron_hurt():
	ron_panel.anim_hurt()

func _on_syd_hurt():
	syd_panel.anim_hurt()

func update_choices(dino: Fighter, choices):
	var idx := 0
	for action in dino.actions:
		choices.show_action(idx, action)
		idx += 1

func _on_ron_actions_modified(dino):
	update_choices(dino, ron_choices)

func _on_syd_actions_modified(dino):
	update_choices(dino, syd_choices)

func _on_enemy_hurt():
	enemy_hurt_anim = 1.0

func _on_enemy_actions_modified(dino):
	incoming.set_action(dino.actions[0])
