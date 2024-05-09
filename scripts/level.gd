class_name Level
extends Node2D

signal change_level(newLevelPath, levelName)

@export var levelName:String
@export var player:CharacterBody2D


func _ready():
	# Check the level for any level portals and connect a handler to their portal_entered signal
	for portal in find_children("*","LevelPortal"):
		portal.connect("portal_entered", _on_portal_entered)
	


# Handle a signal from any level portal by signaling for the game to perform a level change. 
# Each portal has a property that stores which level should be loaded. 
# The current level name is sent in case the next level wants to us this info for things 
# like player spawn location
func _on_portal_entered(targetLevelPath):
	change_level.emit(targetLevelPath, levelName)
