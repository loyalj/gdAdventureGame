class_name LevelPortal
extends Area2D

signal portal_entered(targetLevelPath)

@export var targetLevelPath:String


func _on_body_entered(body):
	portal_entered.emit(targetLevelPath)
