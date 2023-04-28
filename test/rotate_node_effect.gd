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
@export var node: Node2D
@export var direction := Vector2.RIGHT
@export var angle_offest := 0.0

# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
func _process(_delta):
	_set_rotation()
	
	
# -- 16 public methods
# -- 17 private methods
func _set_rotation():
	node.global_rotation = direction.angle() + deg_to_rad(angle_offest)
	
	
# -- 18 signal listeners
func on_direction_changed(direction: Vector2):
	self.direction = direction
	
	
# -- 19 subclasses

