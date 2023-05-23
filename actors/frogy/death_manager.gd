# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
signal death()
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
# -- 09 public variables
# -- 10 private variables
var _frogy: Frogy

# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	_frogy = owner
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
# -- 17 private methods
func _die():
	_frogy.movement_manager.stop()
	_frogy.collision_shape_2d.disabled = true
	death.emit()
	
# -- 18 signal listeners
func on_collision_found(collision: KinematicCollision2D):
	if collision.get_collider().is_in_group("wall_death"):
		_die()
# -- 19 subclasses

