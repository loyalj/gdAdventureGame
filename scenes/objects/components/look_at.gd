# This component creates a mouse over region which can initate the following actions:
# - Change the mouse cursor to a custom graphic which an be set in the node inspector
# - Emit a signal so that other nodes can respond to a mouse click, This also sends a
#   snippet of dialgo the responding node can display.

class_name LookAt
extends Node2D

signal looked_at(dialog)

@export var lookAtDialog:String

var isActive:bool = true
var mouseOver:bool = false


# When the mouse enters we want to switch to the custom cursor
# and flip the mouse over flag for our click event to use later
func _on_mouse_entered():
	if isActive:
		mouseOver = true
		MouseManager.set_mouse_cursor(MouseManager.Cursors.LOOK_AT)


# When the mouse exits we want to switch to the default cursor from the project settings
# and flip the mouse over flag for our click event to use later
func _on_mouse_exited():
	if isActive:
		mouseOver = false
		MouseManager.set_mouse_cursor(MouseManager.Cursors.DEFAULT)


# Check for mouse clicks which haven't been handled by a GUI layer, or a different game object
func _unhandled_input(event):
	if event.is_action_pressed("lmb_click") and mouseOver and isActive:
		get_viewport().set_input_as_handled() # Prevents player from moving when they interact with the switch
		looked_at.emit(lookAtDialog)


# The lookAt node can have an optional area used to detect when the player has approached the node.
# Then deactivates the look at functionality. This helps with cases like a switch where the look at
# ares will block the users ability to flip the switch. 
func _on_deactivate_distance_body_entered(body):
	isActive = false


func _on_deactivate_distance_body_exited(body):
	isActive = true
