extends Control

@export var map: Panel
@onready var score: Label = $Score

func _ready():
	Global.OnMapOpenUpdate.connect(map_open)
	Global.OnMapCloseUpdate.connect(map_close)

func _process(delta):
	score.text = str("SCORE: ", Global.score)

func map_open():
	map.visible = true

func map_close():
	map.visible = false
