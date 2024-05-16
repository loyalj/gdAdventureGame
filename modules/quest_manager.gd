class_name QuestManagerClass
extends Node

var worldState = {}

func set_value(level, key, value):
	if worldState.has(level):
		worldState[level][key] = value


func get_value(level, key):
	if worldState.has(level):
		if worldState[level].has(key):
			return worldState[level][key]


func has_value(level, key):
	if worldState.has(level):
		return worldState[level].has(key)


func add_level(level):
	if !worldState.has(level):
		worldState[level] = {}


func has_level(level):
	return worldState.has(level)
