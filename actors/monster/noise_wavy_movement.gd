# -- 01 @tool
# -- 02 class_name
class_name NoiseWavyMovement
# -- 03 extends
extends Node2D

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables

@export var movement_manager: MovementManager
@export var easy_noise: EasyNoise

@export_group("Movement Limits")
@export var min_x := 0
@export var max_x := 200


# -- 09 public variables
# -- 10 private variables
var _desired_position := Vector2.ZERO

# -- 11 onready variables
@onready var character := owner
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	easy_noise.output_min = min_x
	easy_noise.output_max = max_x


# -- 15 remaining built-in virtual methods
func _process(delta):
#	print("XXX: noise_value: ", noise_value)
	var desired_position_x = easy_noise.noise_value
	_desired_position = Vector2(desired_position_x, character.global_position.y)
#	print("XXX: _desired_position_x: ", _desired_position_x)
	
	if _desired_position.distance_to(character.global_position) < 10:
		movement_manager.direction = Vector2.ZERO
	else:
		movement_manager.direction = character.global_position.direction_to(_desired_position)

	queue_redraw()
	

func _draw():
	pass
	# draw_circle(_desired_position - global_position, 10, Color.RED)
	
	
# -- 16 public methods
# -- 17 private methods		
# -- 18 signal listeners
# -- 19 subclasses

