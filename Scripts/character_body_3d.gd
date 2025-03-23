extends CharacterBody3D

var is_stop : bool
var nav_points : Array
var nav_clean : Array

@onready var animation_player: AnimationPlayer = $humanoid/AnimationPlayer
@onready var nav: NavigationAgent3D = $NavigationAgent3D
@onready var cpu_particles_3d: CPUParticles3D = $CPUParticles3D
@export var nav_reg: NavigationRegion3D
@export var cubes: Node
@export var monster: Node3D

const COIN = preload("res://Scenes/coin.tscn")
const SPEED = 20.0

func reset_target():
	is_stop = false

func get_position_point():
	var rand_num = randi_range(0, nav_points.size() - 1)
	if nav_points[rand_num].y > 0.5:
		return get_position_point()
	return nav_points[rand_num]

func update_map_pos():
	Global.coins_pos = nav_clean
	Global.cubes_pos = cubes.get_children()
	Global.player_pos = global_position
	Global.enemy_pos = monster.global_position

func _ready():
	Global.OnMapCloseUpdate.connect(reset_target)
	
	update_map_pos()
	var cube_children = cubes.get_children()
	for i in cube_children:
		pass
	
	nav_points = nav_reg.navigation_mesh.get_vertices()
	var i = 0
	while i < 40:
		i += 1
		var coin = COIN.instantiate()
		coin.position = get_position_point() + Vector3(0, 4, 0)
		get_parent().add_child.call_deferred(coin)
		nav_clean.append(coin.position)
		

	animation_player.play("Swimming-2/mixamo_com")
	cpu_particles_3d.emitting = true

func _physics_process(_delta):
	update_map_pos()
	animation_player.play("Swimming-2/mixamo_com")
	
	var direction = Vector3()
	
	nav.target_position = Global.target.global_position
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	$humanoid.rotation.y = atan2(direction.x, direction.z)
	var distance = nav.get_final_position().distance_to(global_position)
	if distance < 1.5 and distance > 1.0:
		is_stop = true
		
	if is_stop:
		Global.OnMapOpenUpdate.emit() 
		return
		
	velocity = direction * SPEED
		
		
	move_and_slide()
