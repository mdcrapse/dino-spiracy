extends TextureRect

@onready var anim: AnimationPlayer = $Anim

signal activated()

func anim_attack(action: Action):
	texture = action.texture
	$CenterContainer/HeartLoss/Anim.play("lose_heart")
	return $CenterContainer/HeartLoss/Anim.animation_finished

func activate():
	activated.emit()

func anim_activate() -> Signal:
	anim.stop(true)
	anim.play("activate")
	return activated
