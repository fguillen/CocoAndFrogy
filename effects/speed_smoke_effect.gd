# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends CPUParticles2D

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var speed_threshold := 1500.0

# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func on_speed_changed(speed: float):
	if speed > speed_threshold:
		emitting = true
	else:
		emitting = false
		

func on_direction_changed(direction: Vector2):
	global_rotation = direction.angle()
		
	
	
# -- 17 private methods
# -- 18 signal listeners
# -- 19 subclasses

