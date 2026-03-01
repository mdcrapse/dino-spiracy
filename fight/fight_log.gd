extends Control

const FightLogEntry := preload("res://fight/fight_log_entry.tscn")

@onready var entries = $Entries

# Logs the message directly to the fight log.
func log_msg(text: String):
	var entry := FightLogEntry.instantiate()
	entry.text = "- " + text
	entries.add_child(entry)
	entries.move_child(entry, 0)

# Logs the characters action to the fight log.
func log_action(character: String, action: String):
	log_msg(character + " " + action + "s")
