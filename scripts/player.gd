extends CharacterBody2D

var moveTarget = null

@export var speed = 500

@export var nav: NavigationAgent2D
@export var cam: Camera2D

func _ready():
	moveTarget = global_position


func _unhandled_input(event):
	if event.is_action_pressed("lmb_click"):
		moveTarget = cam.get_global_mouse_position()
		nav.target_position = moveTarget


func _process(_delta):
	velocity = global_position.direction_to(nav.get_next_path_position()) * speed
	
	if global_position.distance_to(nav.get_next_path_position()) > 10:
		move_and_slide()


# Move the player and camera instantaneously without smooth panning
func set_player_position(new_position):
	get_tree().paused = false
	global_position = new_position
	cam.global_position = new_position
	cam.reset_smoothing()
