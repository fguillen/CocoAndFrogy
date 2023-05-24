# -- 01 @tool
# -- 02 class_name
class_name InputManagerTouch
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
signal bump_received()
signal direction_changed(direction: Vector2)


# -- 06 enums
# -- 07 constants
# -- 08 exported variables
# -- 09 public variables
# -- 10 private variables
var _last_direction := Vector2.ZERO
var _character: Node2D
var _touch_position := Vector2.ZERO

# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	_character = owner
	
	
# -- 15 remaining built-in virtual methods
func _process(_delta):
	var actual_direction = _get_input_vector()
	if _last_direction != actual_direction:
		direction_changed.emit(actual_direction)
		_last_direction = actual_direction
	
	if _get_bump():
		bump_received.emit()
	
	
# -- 16 public methods
func touch_position_changed(new_position: Vector2):
	_touch_position = new_position
	
	
# -- 17 private methods
func _get_input_vector() -> Vector2:
	var input_vector = _touch_position - _character.position
	return input_vector.normalized()
	

func _get_bump() -> bool:
	return false #Input.is_action_just_pressed("bump")
	
# -- 18 signal listeners
# -- 19 subclasses

