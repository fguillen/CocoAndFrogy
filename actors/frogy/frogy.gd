# -- 01 @tool
# -- 02 class_name
class_name Frogy
# -- 03 extends
extends Character

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	movement_manager.direction = Vector2.DOWN
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func boost(factor: float):
	movement_manager.speed *= factor
	
	
# -- 17 private methods
# -- 18 signal listeners
# -- 19 subclasses
