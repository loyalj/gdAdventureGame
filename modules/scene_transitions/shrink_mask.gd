extends CanvasLayer

@export var textureRect:TextureRect

# Expose the animation player so the scene manager can use it
@export var animationPlayer: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	textureRect.texture = ImageTexture.create_from_image(get_viewport().get_texture().get_image())
