class_name Action

var name: String
var type: Type = Type.BASIC
var desc: String
var texture: Texture2D

func is_status() -> bool:
	return type == Type.BUFF or type == Type.DEBUFF

func is_instant() -> bool:
	return type == Type.INSTANT

func activates_on_turn_start() -> bool:
	return has_method("on_turn_start")

func activates_on_turn_end() -> bool:
	return has_method("on_turn_end")

# ========== OVERRIDES ==========

func on_enter_dino(dino, all: Array):
	pass

func on_exit_dino(dino, all: Array):
	pass

#func on_turn_start(dino, all: Array):
	#pass

#func on_turn_end(dino, all: Array):
	#pass

func on_other_enter_dino(dino, all: Array, other: Action):
	pass

func is_allowed_to_play(dino, all: Array, action: Action) -> bool:
	return true

## Only occurs when using an instant card.
func on_instant_use():
	pass

## Returns the display name of the type.
func type_name() -> String:
	match type:
		Type.BASIC:
			return "Basic Attack"
		Type.SPECIAL:
			return "Special Attack"
		Type.BUFF:
			return "Self-Buff"
		Type.DEBUFF:
			return "Foe-Debuff"
		Type.INSTANT:
			return "Instant"
	return "???"

enum Type {
	BASIC,
	SPECIAL,
	BUFF,
	DEBUFF,
	INSTANT
}
