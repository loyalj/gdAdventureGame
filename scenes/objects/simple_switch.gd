class_name SimpleSwitch
extends Node2D

signal switch_flipped(switchName, switchOn)

@export var switchName:String

@onready var animate:AnimationPlayer = $AnimationPlayer

var switchOn:bool = true
var mouseOver:bool = false
var currentState:switchStates

enum switchStates {
	IDLE,
	PLAYER_ENTERED,
	PLAYER_EXITED
}

func _ready():
	changeState(switchStates.IDLE)


func changeState(newState):
	currentState = newState
	
	match newState:
		switchStates.IDLE:
			MouseManager.set_mouse_cursor(MouseManager.Cursors.DEFAULT)
		
		switchStates.PLAYER_ENTERED:
			if mouseOver:
				MouseManager.set_mouse_cursor(MouseManager.Cursors.ACTIVATE)
		
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
		MouseManager.set_mouse_cursor(MouseManager.Cursors.ACTIVATE)


func _on_activation_area_mouse_exited():
	mouseOver = false
	MouseManager.set_mouse_cursor(MouseManager.Cursors.DEFAULT)


func _unhandled_input(event):
	if event.is_action_pressed("lmb_click") and mouseOver:
		
		get_viewport().set_input_as_handled() # Prevents player from moving when they interact with the switch
		
		match currentState:
			switchStates.PLAYER_ENTERED:
				flip_switch()

# TODO Separate click area from player activation overlap area, so that we can improve the feel of this interaction

# TODO Add state to turn off input when the switch is animating
