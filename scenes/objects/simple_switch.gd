class_name SimpleSwitch
extends Node2D

signal looked_at(dialog)
signal switch_flipped(switchName, switchOn)

@export var switchName:String
@export var lookAtDialog:String
@export var mouseActivate:CompressedTexture2D 
@export var mouseLookAt:CompressedTexture2D

@onready var animate:AnimationPlayer = $AnimationPlayer

var switchOn:bool = true
var mouseOver:bool = false
var defaultMouseCursor:CompressedTexture2D
var cursorHotspot:Vector2
var currentState:switchStates

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
			if mouseOver:
				Input.set_custom_mouse_cursor(mouseActivate, Input.CURSOR_ARROW, cursorHotspot)
		
		switchStates.PLAYER_EXITED:
			changeState(switchStates.IDLE)


func flip_switch():
	match switchOn:
		false:
			switchOn = true
			animate.play("switch_on")
		
		true:
			switchOn = false
			animate.play("switch_off")
	
	switch_flipped.emit(switchName, switchOn)


func set_switch(newValue):
	switchOn = newValue
	match switchOn:
		true:
			animate.play("switch_on")
		false:
			animate.play("switch_off")
	
	animate.seek(animate.current_animation_length)


func _on_activation_area_body_entered(_body):
	changeState(switchStates.PLAYER_ENTERED)


func _on_activation_area_body_exited(_body):
	changeState(switchStates.PLAYER_EXITED)


func _on_activation_area_mouse_entered():
	mouseOver = true
	if currentState == switchStates.PLAYER_ENTERED:
		Input.set_custom_mouse_cursor(mouseActivate, Input.CURSOR_ARROW, cursorHotspot)
	else:
		Input.set_custom_mouse_cursor(mouseLookAt, Input.CURSOR_ARROW, cursorHotspot)


func _on_activation_area_mouse_exited():
	mouseOver = false
	Input.set_custom_mouse_cursor(defaultMouseCursor, Input.CURSOR_ARROW, cursorHotspot)


func _unhandled_input(event):
	if event.is_action_pressed("lmb_click") and mouseOver:
		
		get_viewport().set_input_as_handled() # Prevents player from moving when they interact with the switch
		
		match currentState:
			switchStates.PLAYER_ENTERED:
				flip_switch()
			
			switchStates.IDLE:
				looked_at.emit(lookAtDialog)

# TODO Separate click area from player activation overlap area, so that we can improve the feel of this interaction

# TODO Add state to turn off input when the switch is animating
