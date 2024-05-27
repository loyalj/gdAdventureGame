extends Node



var defaultMouseCursor:CompressedTexture2D
var mouseLookAt:CompressedTexture2D = load("res://assets/mouse_look_at.png")
var mouseOpenDoor:CompressedTexture2D = load("res://assets/mouse_open_door.png")
var mouseActivate:CompressedTexture2D = load("res://assets/mouse_activate.png")

var cursorHotspot:Vector2

enum Cursors {
	DEFAULT,
	LOOK_AT,
	OPEN_DOOR,
	ACTIVATE	
}

func _ready():
	cursorHotspot = ProjectSettings.get_setting("display/mouse_cursor/custom_image_hotspot")
	defaultMouseCursor = load(ProjectSettings.get_setting("display/mouse_cursor/custom_image"))

func set_mouse_cursor(newCursor:Cursors):
	var cursorPath

	match newCursor:
		Cursors.DEFAULT:
			cursorPath = defaultMouseCursor
		Cursors.LOOK_AT:
			cursorPath = mouseLookAt
		Cursors.OPEN_DOOR:
			cursorPath = mouseOpenDoor
		Cursors.ACTIVATE:
			cursorPath = mouseActivate
	
	Input.set_custom_mouse_cursor(cursorPath, Input.CURSOR_ARROW, cursorHotspot)
