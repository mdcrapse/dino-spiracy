extends Control

var enemy_hp: int = 100
var hp: int = 100

var transitioning: bool = false

@onready var fight_log := %FightLog
@onready var boss_hp = %BossHP
@onready var ron_health = $SafeMargin/Control/SydFightPanel/MarginContainer/VBoxContainer/Control/Health
@onready var syd_health = $SafeMargin/Control/RonFightPanel/MarginContainer/VBoxContainer/Control/Health
@onready var transition = $Transition
@onready var game_over = $Transition/GameOver
@onready var ko = $Transition/KO

func _ready():
	transition.modulate = Color.WHITE

func _process(delta):
	game_over.visible = hp == 0
	ko.visible = enemy_hp == 0
	
	if transitioning and (hp == 0 or enemy_hp == 0):
		transition.modulate = transition.modulate.lerp(Color.WHITE, delta * 5)
	else:
		transition.modulate = transition.modulate.lerp(Color(1, 1, 1, 0), delta * 5)

func _on_syd_fight_choice_chose(option):
	if hp > 0:
		fight_log.log_action('Syd', option)
		if option == "Rest":
			heal(1)
		else:
			hurt(2)

func _on_ron_fight_choice_chose(option):
	if hp > 0:
		fight_log.log_action('Ron', option)
		if option == "Rest":
			heal(2)
		else:
			hurt(1)

func hurt(amount: int):
	enemy_hp -= amount
	enemy_hp = max(enemy_hp, 0)
	boss_hp.scale.x = enemy_hp / 100.0
	
	if enemy_hp <= 0:
		transitioning = true
	
func hurt_plr(amount: int):
	hp -= amount
	hp = max(hp, 0)
	ron_health.scale.x = hp / 100.0
	syd_health.scale.x = hp / 100.0
	
	if hp <= 0:
		transitioning = true

func heal(amount: int):
	hp += amount
	hp = min(hp, 100)
	ron_health.scale.x = hp / 100.0
	syd_health.scale.x = hp / 100.0

func _on_timer_timeout():
	if enemy_hp > 0:
		hurt_plr(25)
