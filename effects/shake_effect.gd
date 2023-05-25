# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node

# -- 04 # docstring
# Inspired by: https://kidscancode.org/godot_recipes/3.x/2d/screen_shake/index.html

#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export_group("Target")
@export var target: Node

@export_group("Shake")
@export var decay = 0.8  # How quickly the shaking stops [0, 1].
@export var max_offset = Vector2(100, 75)  # Maximum hor/ver shake in pixels.
@export var max_rotation = 0.1  # Maximum rotation in radians (use sparingly).
@export var trauma_power := 2 # Trauma exponent. Use [2, 3].
	
@export_group("Noise")
@export var noise: Noise
@export var speed := 1
	

# -- 09 public variables
# -- 10 private variables
var _noise_offset := 0.0
var _trauma = 0.0  # Current shake strength.


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
	if _trauma:
		_trauma = max(_trauma - (decay * delta), 0)
		_shake(delta)
		
		
# -- 16 public methods
func trauma(value: float): # From 0.0 to 1.0
	_trauma = value
	
	
# -- 17 private methods
func _shake(delta):
	var amount = pow(_trauma, trauma_power)
	_noise_offset += (speed * delta)
	target.rotation = max_rotation * amount * noise.get_noise_2d(_noise_offset, 0)
	target.offset.x = max_offset.x * amount * noise.get_noise_2d(_noise_offset, 1000)
	target.offset.y = max_offset.y * amount * noise.get_noise_2d(_noise_offset, 3000)
	
	print("XXX: _noise_offset: %.3f, offset_x: %.3f, max: %.3f, noise: %.10f" % [_noise_offset, target.offset.x, max_offset.x, noise.get_noise_2d(_noise_offset, 0)])
	
# -- 18 signal listeners
# -- 19 subclasses

