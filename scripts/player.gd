class_name AdventurePlayer
extends CharacterBody2D

var moveTarget = null
var dialogDisplayTime:float = 3.0

@export var speed = 300

@export var nav: NavigationAgent2D
@export var cam: Camera2D
@export var dialogBox: Label


func _ready():
	moveTarget = global_position


func _unhandled_input(event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		moveTarget = cam.get_global_mouse_position()
		nav.target_position = moveTarget
		dialogBox.hide()


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


func show_dialog(dialog):
	dialogBox.text = dialog
	dialogBox.show()
	
	await get_tree().create_timer(dialogDisplayTime).timeout
	
	dialogBox.hide()
