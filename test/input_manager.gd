# -- 01 @tool
# -- 02 class_name
class_name InputManager
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
signal direction_changed(direction: Vector2)

# -- 06 enums
# -- 07 constants
# -- 08 exported variables
# -- 09 public variables
var direction := Vector2.ZERO : set = _set_direction

# -- 10 private variables
# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
func _process(_delta):
	self.direction = _get_input()
	
# -- 16 public methods
# -- 17 private methods
func _get_input() -> Vector2:
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	return input_dir
	

func _set_direction(value: Vector2):
	var previous_direction = Vector2(direction)
	direction = value.normalized()
	
	if previous_direction != direction:
		direction_changed.emit(direction)
		
	
# -- 18 signal listeners
# -- 19 subclasses

