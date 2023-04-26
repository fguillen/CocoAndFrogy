# -- 01 @tool
#@tool
# -- 02 class_name
class_name WavyLine
# -- 03 extends
extends Node2D

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export_range(10, 2000, 1) var speed_min := 100
@export_range(10, 2000, 1) var speed_max := 400

# -- 09 public variables
# -- 10 private variables
var _speed: int
var _direction := Vector2.RIGHT
var _window_width: int
var _texture_width: float
var _position_initial: Vector2
var _position_delta := Vector2.ZERO

# -- 11 onready variables
@onready var lines_collection = $LinesCollection
@onready var line_demostration = $LineDemostration

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	randomize()
	
	_window_width = int(get_viewport().get_visible_rect().size.x)
	_position_initial = global_position
	_texture_width = line_demostration.texture.get_width() * line_demostration.scale.x
	_setup_sprites()
	_randomize()
	
	line_demostration.visible = false
	
	
# -- 15 remaining built-in virtual methods
func _process(delta):
	_position_delta += _speed * _direction * delta
	
	if _position_delta.x < -(_texture_width - _window_width):
		_position_delta.x += _texture_width
	elif _position_delta.x > _texture_width:
		_position_delta.x -= _texture_width
		
	global_position = _position_initial + _position_delta
	
# -- 16 public methods
# -- 17 private methods
func _setup_sprites():
	var _lines = lines_collection.get_children()
	
	var sprite_template: Sprite2D = _lines.pick_random()
	
	var sprite_clone_1 = sprite_template.duplicate()
	add_child(sprite_clone_1)
	sprite_clone_1.global_position = global_position
	
	var sprite_clone_2 = sprite_template.duplicate()
	add_child(sprite_clone_2)
	sprite_clone_2.global_position = Vector2(global_position.x - _texture_width, global_position.y) 
	
	
func _randomize():
	_speed = randi_range(speed_min, speed_max)
	if randi_range(0, 1) == 1:
		_direction.x = -_direction.x
	
# -- 18 signal listeners
# -- 19 subclasses

