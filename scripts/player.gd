extends CharacterBody2D

var moveTarget = null
var windowDimensions

@export var speed = 300
@export var heightCurve : Curve

@onready var nav: NavigationAgent2D = $NavigationAgent2D
@onready var cam: Camera2D = $Camera2D

func _ready():
	moveTarget = global_position
	windowDimensions = get_viewport_rect()

func _input(event):
	if event.is_action_pressed("lmb_click"):
		moveTarget = cam.get_global_mouse_position()
		nav.target_position = moveTarget

func _process(delta):
	velocity = global_position.direction_to(nav.get_next_path_position()) * speed
	
	if global_position.distance_to(nav.get_next_path_position()) > 10:
		move_and_slide()
