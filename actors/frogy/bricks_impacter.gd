# -- 01 @tool
# -- 02 class_name
class_name BricksImpacter

# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
signal collision_found()

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
# -- 15 remaining built-in virtual methods
# -- 16 public methods
# -- 17 private methods
# -- 18 signal listeners
func on_collision_found(collision: KinematicCollision2D):
	if collision.get_collider().is_in_group("bricks"):
		collision.get_collider().impact()
		collision_found.emit()
		
# -- 19 subclasses

