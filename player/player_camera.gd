extends Camera2D

func _ready():
	position_between_players()
	reset_smoothing()

func _process(delta):
	position_between_players()

func position_between_players():
	var players = get_tree().get_nodes_in_group("player")
	if not players.is_empty():
		var pos = Vector2.ZERO
		for plr: Node2D in players:
			pos += plr.position + Vector2(0, -96)
		position = pos / players.size()
