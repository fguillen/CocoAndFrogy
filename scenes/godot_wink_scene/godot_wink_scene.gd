extends Control

signal accelerate()

@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D


func wink() -> void:
	animated_sprite.play("wink")
	
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		accelerate.emit()
		
	if event is InputEventScreenTouch and event.double_tap:
		accelerate.emit()
