class_name LevelPortal
extends Area2D

signal portal_entered(targetLevelPath)

@export var targetLevelPath:String

var mouseOpenDoor:CompressedTexture2D = load("res://assets/mouse_open_door.png")
var defaultMouseCursor:CompressedTexture2D
var cursorHotspot:Vector2


func _ready():
	cursorHotspot = ProjectSettings.get_setting("display/mouse_cursor/custom_image_hotspot")
	defaultMouseCursor = load(ProjectSettings.get_setting("display/mouse_cursor/custom_image"))


# Main event that handles when the player overlaps a portal.  
# Currently this means emitting an event that the main game can listen for.
func _on_body_entered(_body):
	portal_entered.emit(targetLevelPath)


func _on_mouse_entered():
	Input.set_custom_mouse_cursor(mouseOpenDoor, Input.CURSOR_ARROW, cursorHotspot)


func _on_mouse_exited():
	Input.set_custom_mouse_cursor(defaultMouseCursor, Input.CURSOR_ARROW, cursorHotspot)
