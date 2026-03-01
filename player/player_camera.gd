extends Camera2D

func _process(delta):
	position_between_players(get_tree().get_nodes_in_group("player"))

func position_between_players(players: Array[Node]):
	var pos = Vector2.ZERO
	for plr: Node2D in players:
		pos += plr.position
	position = pos / players.size()
