extends Node

signal OnMapOpenUpdate()
signal OnMapCloseUpdate()
signal coin_collected(pos)

var score : int = 0

var coins_pos
var cubes_pos
var player_pos
var enemy_pos

@onready var target: Marker3D = get_node("/root/Root/Target")
var min_range : Vector3 = Vector3(-320, 0, -320)
var max_range : Vector3 = Vector3(320, 0, 320)

func _ready():
	var rand_x = randi_range(min_range.x, max_range.x)
	var rand_z = randi_range(min_range.z, max_range.z)
	target.position = Vector3(rand_x , 0, rand_z)
