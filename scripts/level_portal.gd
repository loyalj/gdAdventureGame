class_name LevelPortal
extends Area2D

signal portal_entered(targetLevelPath)

@export var targetLevelPath:String

var mouseOpenDoor = load("res://assets/mouse_open_door.png")
var defaultMouseCursor


func _ready():
	var defaultMouseCursorPath = ProjectSettings.get_setting("display/mouse_cursor/custom_image")
	defaultMouseCursor = load(defaultMouseCursorPath)


func _on_body_entered(_body):
	portal_entered.emit(targetLevelPath)


func _on_mouse_entered():
	Input.set_custom_mouse_cursor(mouseOpenDoor, Input.CURSOR_ARROW, ProjectSettings.get_setting("display/mouse_cursor/custom_image_hotspot"))


func _on_mouse_exited():
	Input.set_custom_mouse_cursor(defaultMouseCursor, Input.CURSOR_ARROW, ProjectSettings.get_setting("display/mouse_cursor/custom_image_hotspot"))
