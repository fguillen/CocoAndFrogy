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
var _state_machine: AnimationNodeStateMachinePlayback 

# -- 11 onready variables
@onready var animation_tree: AnimationTree = %AnimationTree
@onready var animation_player_bump: AnimationPlayer = $AnimationPlayerBump

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	animation_tree.active = true
	_state_machine = animation_tree["parameters/playback"]
	_state_machine.travel("look_right")
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
# -- 17 private methods
func _set_looking_towards(direction: Vector2):
	if direction.x == 0:
		return 
		
	var looking_towards = "right" if direction.x > 0 else "left"
	_state_machine.travel("look_%s" % looking_towards)

# -- 18 signal listeners
func on_change_direction(direction: Vector2):
	_set_looking_towards(direction)
	
	
func on_bumped():
	animation_player_bump.play("bump")
#	_state_machine.travel("bump")
# -- 19 subclasses
