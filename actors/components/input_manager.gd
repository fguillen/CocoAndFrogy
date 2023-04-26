# -- 01 @tool
# -- 02 class_name
class_name InputManager
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var movement_manager: MovementManager

# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
func _process(_delta):
	movement_manager.direction = _get_input()
	
# -- 16 public methods
# -- 17 private methods
func _get_input() -> Vector2:
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	return input_dir
	
	
# -- 18 signal listeners
# -- 19 subclasses

