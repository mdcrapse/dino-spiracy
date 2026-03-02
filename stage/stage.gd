extends Node2D

@onready var day_1 = $Day1
@onready var day_2 = $Day2
@onready var day_3 = $Day3

func _ready():
	if Game.day != 1:
		day_1.free()
	if Game.day != 2:
		day_2.free()
	if Game.day != 3:
		day_3.free()
