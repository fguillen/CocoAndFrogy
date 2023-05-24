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
@export var decceleration_rate: float = 0.3
@export var movement_manager: MovementManager

# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
func _physics_process(delta):
	print("XXX: movement_manager.speed: ", movement_manager.speed)
	movement_manager.speed = lerp(movement_manager.speed, movement_manager.initial_speed, decceleration_rate * delta)
	
	
# -- 16 public methods
# -- 17 private methods
# -- 18 signal listeners
# -- 19 subclasses

