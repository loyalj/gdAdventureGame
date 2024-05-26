class_name Level
extends Node2D

signal change_level(newLevelPath, levelName)

@export var levelName:String
@export var player:AdventurePlayer


func _ready():
	# Check if level data exists, if not then create some for this level
	if !QuestManager.has_level(levelName):
		QuestManager.add_level(levelName)
	
	activate_portals()
	activate_switches()
	activate_look_ats()
	check_camera_limits()
	

func check_camera_limits():
	var topLeft = find_child("CameraTopLeft")
	var bottomRight = find_child("CameraBottomRight")
	
	if topLeft:
		player.cam.limit_top = topLeft.position.y
		player.cam.limit_left = topLeft.position.x
	
	if bottomRight:
		player.cam.limit_bottom = bottomRight.position.y
		player.cam.limit_right = bottomRight.position.x


# Check the level for any level portals and handle their signals
func activate_portals():
	for portal in find_children("*","LevelPortal"):
		portal.connect("portal_entered", _on_portal_entered)


# Check the level for any simple switches and handle their signals
	# Then load or setup storage for them in the quest manager's world state
func activate_switches():
	for simpleSwitch:SimpleSwitch in find_children("*","SimpleSwitch"):
		simpleSwitch.connect("switch_flipped", _on_switch_flipped)
		
		if !QuestManager.has_value(levelName, simpleSwitch.switchName):
			QuestManager.set_value(levelName, simpleSwitch.switchName, simpleSwitch.switchOn)
		else:
			simpleSwitch.set_switch(QuestManager.get_value(levelName, simpleSwitch.switchName))


# Check the level for any LookAt Components and connect to their signal
func activate_look_ats():
	for lookAt:LookAt in find_children("*","LookAt"):
		lookAt.connect("looked_at", _on_something_looked_at)


# Handle a signal from any level portal by signaling for the game to perform a level change. 
# Each portal has a property that stores which level should be loaded. 
# The current level name is sent in case the next level wants to us this info for things 
# like player spawn location
func _on_portal_entered(targetLevelPath):
	change_level.emit(targetLevelPath, levelName)


# Tell the player to display dialog ff the level receives a something looked at signal
func _on_something_looked_at(dialog):
	player.show_dialog(dialog)

# Listen for switches getting flipped and save the new value to the quest manager
func _on_switch_flipped(switchName, switchOn):
	QuestManager.set_value(levelName, switchName, switchOn)
