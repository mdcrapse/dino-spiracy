extends TextureRect

@onready var anim: AnimationPlayer = $Anim

signal activated()

func activate():
	activated.emit()

func anim_activate() -> Signal:
	anim.stop(true)
	anim.play("activate")
	return activated
