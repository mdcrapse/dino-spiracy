extends PanelContainer

const FightChoice := preload("res://fight/fight_choice.gd")

@onready var choices: FightChoice = %FightChoice
@onready var healthbar := %FightHealthBar
