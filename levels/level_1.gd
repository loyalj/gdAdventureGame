extends Level


func _ready():
	$Level2Portal.connect("portal_entered", _on_portal_entered)


func _on_portal_entered(targetLevelPath):
	change_level.emit(targetLevelPath)
