extends PanelContainer

var incoming: Action

@onready var action_label = %ActionLabel
@onready var desc_label = %DescLabel
@onready var action_texture = %ActionTexture
@onready var anim = $AnimationPlayer

func set_action(action: Action):
	incoming = action
	anim.play("change")

func set_action_immediate(action: Action):
	incoming = action
	update_incoming()

func update_incoming():
	if incoming != null:
		action_texture.texture = incoming.texture
		action_label.text = incoming.name
		desc_label.text = incoming.desc
		incoming = null
