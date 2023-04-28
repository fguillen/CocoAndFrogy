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
@export var movement_manager: MovementManager
@export var node: Node2D
@export var max_scale_factor := Vector2(0.8, 1.2)

# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
@onready var _base_scale := node.scale
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
func _process(_delta):
	node.scale = lerp(_base_scale, _base_scale * max_scale_factor, movement_manager.character.velocity.length() / movement_manager.speed)
# -- 16 public methods
# -- 17 private methods
# -- 18 signal listeners
# -- 19 subclasses

