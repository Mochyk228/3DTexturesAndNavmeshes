extends CharacterBody3D

@onready var animation_player: AnimationPlayer = $humanoid/AnimationPlayer
@onready var nav: NavigationAgent3D = $NavigationAgent3D

const SPEED = 20.0
var is_switch : bool

func _ready():
	animation_player.play("Swimming-2/RESET")
	$humanoid.position.y = 6.77

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if not is_switch:
			animation_player.play("Swimming-2/mixamo_com")
			$humanoid.position.y = 0
			is_switch = true
		else:
			animation_player.play("Swimming-2/RESET")
			$humanoid.position.y = 6.77
			is_switch = false
	
func _physics_process(_delta):
	var direction = Vector3()
	
	if nav.get_final_position() - global_position < Vector3(0.2, 0, 0.2):
		nav.target_position = Global.target.global_position
		direction = nav.get_next_path_position() - global_position
		direction = direction.normalized()
		velocity = direction * SPEED
		
	move_and_slide()
