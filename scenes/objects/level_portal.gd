class_name LevelPortal
extends Area2D

signal portal_entered(targetLevelPath)

@export var targetLevelPath:String


# Main event that handles when the player overlaps a portal.  
# Currently this means emitting an event that the main game can listen for.
func _on_body_entered(_body):
	portal_entered.emit(targetLevelPath)


func _on_mouse_entered():
	MouseManager.set_mouse_cursor(MouseManager.Cursors.OPEN_DOOR)


func _on_mouse_exited():
	MouseManager.set_mouse_cursor(MouseManager.Cursors.DEFAULT)
