# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node2D

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
@onready var jumping_animation_player = $JumpingAnimationPlayer
@onready var show_animation_player = $ShowAnimationPlayer

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func perform():
	show_animation_player.play("show")
	await show_animation_player.animation_finished
	show_animation_player.play("waving")
	await get_tree().create_timer(0.2).timeout
	jumping_animation_player.play("jump")

# -- 17 private methods
# -- 18 signal listeners
# -- 19 innerclasses

