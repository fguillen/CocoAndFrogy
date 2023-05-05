# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
# -- 09 public variables
# -- 10 private variables
var _loking_towards := "right"
var _state_machine: AnimationNodeStateMachinePlayback 

# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	active = true
	_state_machine = animation_tree["parameters/playback"]
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
# -- 17 private methods
func _set_looking_towards(direction: Vector2):
	var _looking_towards = "right" if sign(direction.x) > 0 else "left"
	play

# -- 18 signal listeners
func on_change_direction(direction: Vector2):
	_set_looking_towards(direction)
# -- 19 subclasses

