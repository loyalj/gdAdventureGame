class_name SimpleSwitch
extends Node2D

@export var switchName:String

@onready var animate:AnimationPlayer = $AnimationPlayer

var value:bool = true
var currentState:switchStates

var mouseInteract:CompressedTexture2D = load("res://assets/mouse_open_door.png")
var defaultMouseCursor:CompressedTexture2D
var cursorHotspot:Vector2

enum switchStates {
	IDLE,
	PLAYER_ENTERED,
	PLAYER_EXITED
}

func _ready():
	cursorHotspot = ProjectSettings.get_setting("display/mouse_cursor/custom_image_hotspot")
	defaultMouseCursor = load(ProjectSettings.get_setting("display/mouse_cursor/custom_image"))
	changeState(switchStates.IDLE)


func changeState(newState):
	currentState = newState
	
	match newState:
		switchStates.IDLE:
			Input.set_custom_mouse_cursor(defaultMouseCursor, Input.CURSOR_ARROW, cursorHotspot)
		switchStates.PLAYER_ENTERED:
			Input.set_custom_mouse_cursor(mouseInteract, Input.CURSOR_ARROW, cursorHotspot)
		switchStates.PLAYER_EXITED:
			changeState(switchStates.IDLE)


func flipSwitch():
	match value:
		false:
			value = true
			animate.play("switch_on")
		true:
			value = false
			animate.play("switch_off")
	


func _on_activation_area_body_entered(body):
	changeState(switchStates.PLAYER_ENTERED)


func _on_activation_area_body_exited(body):
	changeState(switchStates.PLAYER_EXITED)


func _on_activation_area_mouse_entered():
	if currentState == switchStates.PLAYER_ENTERED:
		Input.set_custom_mouse_cursor(mouseInteract, Input.CURSOR_ARROW, cursorHotspot)


func _on_activation_area_mouse_exited():
	Input.set_custom_mouse_cursor(defaultMouseCursor, Input.CURSOR_ARROW, cursorHotspot)


func _on_activation_area_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("lmb_click"):
		match currentState:
			switchStates.PLAYER_ENTERED:
				flipSwitch()
			switchStates.IDLE:
				print("Looks like a switch of some sort, I wonder what it does?")
