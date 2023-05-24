# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Control

# -- 04 # docstring
#
# -- 05 signals
signal position_changed(new_position: Vector2)

# -- 06 enums
# -- 07 constants
# -- 08 exported variables
# -- 09 public variables
var event_position := Vector2.ZERO

# -- 10 private variables
# -- 11 onready variables

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
func _input(event):
	var previous_position = event_position
	
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		event_position = event.position
#	elif event is InputEventMouseButton:
#		event_position = event.position
#	elif event is InputEventMouseMotion:
#		event_position = event.position
	
	if event_position != previous_position:
		position_changed.emit(event_position)
	
# -- 16 public methods
# -- 17 private methods
# -- 18 signal listeners
# -- 19 subclasses

