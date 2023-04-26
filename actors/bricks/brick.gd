# -- 01 @tool
# -- 02 class_name
class_name Brick
# -- 03 extends
extends StaticBody2D

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var health := 2


# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func impact():
	health -= 1
	if health <= 0:
		_die()
	
		
# -- 17 private methods
func _die():
	queue_free()
	
# -- 18 signal listeners
# -- 19 subclasses

