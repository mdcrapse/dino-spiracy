extends Control

@onready var fight_log := %FightLog

func _on_syd_fight_choice_chose(option):
	fight_log.log_action('Syd', option)

func _on_ron_fight_choice_chose(option):
	fight_log.log_action('Ron', option)
