const Action := preload("res://action/action.gd")
const ActionType := Action.Type

static var actions: Dictionary[String, Action] = {
	dodge = action("Dodge", ActionType.BUFF, "Next attack will be dodged"),
}

static func action(name: String, type: ActionType, desc: String, texture: Texture2D) -> Action:
	var a := Action.new()
	a.name = name
	a.type = type
	a.desc = desc
	a.texture = texture
	return a
