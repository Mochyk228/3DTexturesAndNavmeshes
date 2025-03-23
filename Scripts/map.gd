extends Panel

const CUBE_TEXT = preload("res://Scenes/cube_text.tscn")
const COIN_TEXT = preload("res://Scenes/coin_text.tscn")

var is_mouse : bool
var is_one : bool

@onready var player: TextureRect = $Player
@onready var monster: TextureRect = $Monster

var player_texture

func _ready():
	spawn_cubes(Global.cubes_pos, CUBE_TEXT)
	spawn_points(Global.coins_pos, COIN_TEXT)
	Global.coin_collected.connect(update_coins)

func _process(delta):
	move_point(Global.player_pos, player)
	move_point(Global.enemy_pos, monster)
	
	if is_mouse and Input.is_action_just_pressed("left_click"):
		var mouse_pos = get_local_mouse_position() - Vector2(200, 200)
		var mouse_vec = Vector3(mouse_pos.x, 0.4, mouse_pos.y)
		Global.target.global_position = mouse_vec
		Global.OnMapCloseUpdate.emit()
		is_one = false

	
func move_point(point, texture):
	texture.position = Vector2(point.x, point.z) + Vector2(200, 200)

func update_coins(pos):
	if not is_one:
		var children = get_children()
		for child in children:
			if child.is_in_group("Coin"):
				var point = Vector2(pos.x, pos.z) + Vector2(200, 200)
				if point == child.position:
					child.queue_free()
		is_one = true

func spawn_points(array, texture):
	for object in array:
		var object_point = texture.instantiate()
		object_point.position = Vector2(object.x, object.z) + Vector2(200, 200)
		add_child(object_point)

func spawn_cubes(array, texture):
	for object in array:
		var object_point = texture.instantiate()
		object_point.position = Vector2(object.global_position.x, object.global_position.z) + Vector2(200, 200)
		add_child(object_point)


func _on_mouse_entered() -> void:
	is_mouse = true


func _on_mouse_exited() -> void:
	is_mouse = false
