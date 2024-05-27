extends Node2D

@export var gameUI:Control
@export var currentLevel:Level

var lastLevelName: String


func _ready():
	# Sets up the parent node for the scene manager to add/remove levels under 
	SceneManager.set_root_node(self)
	SceneManager.connect("scene_switched", _on_scene_change)
	connect_level_signals()


# Handle and initiate a level change signal from the current level by disconnecting existing signals and asking SceneManager to perform a scene load cross fade 
func _on_change_level(newLevelPath, oldLevelName):
	lastLevelName = oldLevelName
	disconnect_level_signals()
	SceneManager.transition_scene(newLevelPath, "fade_in_out")


# Connect to the current level and listen for signals that the game can consume to coordinate the game flow globally
func connect_level_signals():
	currentLevel.connect("change_level", _on_change_level)


# Disconnect from listening to the current level for signals. This is called before we swap scenes to clean up connections made when the level was loaded. 
func disconnect_level_signals():
	currentLevel.disconnect("change_level", _on_change_level)


# Handle a signal from SceneManager letting us know a new level node has been added to the tree. Connect the game to the new level's signals.
func _on_scene_change(newLevel):
	currentLevel = newLevel
	connect_level_signals()
	reset_mouse_cursor() 
	
	# Set the player's location to match a spawn marker for the level they came from last
	for spawnPoint in get_tree().get_nodes_in_group("PlayerSpawn"):
		if spawnPoint.name == lastLevelName:
			currentLevel.player.set_player_position(
				spawnPoint.global_position)


# The cursor gets stuck as a custom curosr sometimes when objects from an old level get unloaded without resetting it
func reset_mouse_cursor():
	MouseManager.set_mouse_cursor(MouseManager.Cursors.DEFAULT)
