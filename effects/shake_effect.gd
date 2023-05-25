# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node

# -- 04 # docstring
# Inspired by: 
#  - https://kidscancode.org/godot_recipes/3.x/2d/screen_shake/index.html
#  - https://github.com/firebelley/godot-addons/blob/master/node_library/scripts/shaky_camera_2d.gd

#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export_group("Target")
@export var target: Node

@export_group("Shake")
@export var decay = 0.8  # How quickly the shaking stops [0, 1].
@export var use_exponential_decay: bool = false
@export var max_offset = Vector2(100, 75)  # Maximum hor/ver shake in pixels.
	
@export_group("Noise")
@export var noise: FastNoiseLite
@export var frequency_multiplier: float = 100


# -- 09 public variables
# -- 10 private variables
var _noise_offset: float = 0
var _current_shake_percentage = 0;
var _current_direction_rotation = 0


# -- 11 onready variables

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	randomize()
	noise.seed = randi()


# -- 15 remaining built-in virtual methods
func _process(delta):
	if _current_shake_percentage > 0:
		_shake(delta)
		
		
# -- 16 public methods
func perform(percent: float): # From 0.0 to 1.0
	_current_shake_percentage = clamp(_current_shake_percentage + percent, 0, 1)
	
	
# -- 17 private methods
func _shake(delta):
	_noise_offset = wrapf(_noise_offset + delta, 0, 1000) * frequency_multiplier
	var noise_x = noise.get_noise_2d(_noise_offset , 0)
	var noise_y = noise.get_noise_2d(_noise_offset, 1000)
	var noise_rotation = noise.get_noise_2d(_noise_offset, 2000)
	
	var offset_x = noise_x * max_offset.x * _current_shake_percentage
	var offset_y = noise_y * max_offset.y * _current_shake_percentage
	var offset = Vector2(offset_x, offset_y) 
		
	if use_exponential_decay:
		offset *= _current_shake_percentage
		
	target.offset = offset
	
	# decay
	_current_shake_percentage = max(_current_shake_percentage - (decay * delta), 0)
	
# -- 18 signal listeners
# -- 19 subclasses

	
