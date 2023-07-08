extends Control

@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D


func wink() -> void:
	animated_sprite.play("wink")
