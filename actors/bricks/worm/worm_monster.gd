# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node2D

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export_group("Worm")
@export var head: Node2D
@export var body: Node2D
@export var speed := 100.0
@export var bricks_distance := 100.0

@export_group("Path")
@export var path: Path2D
@export var path_follow_template: PathFollow2D


# -- 09 public variables
# -- 10 private variables
var _moving_body_parts: Array[MovingBodyPart]
var _actual_position := 0.0

# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	_init_moving_body_parts()
	
	
# -- 15 remaining built-in virtual methods
func _physics_process(delta):
	_move_moving_body_parts(delta)
	
	
# -- 16 public methods
# -- 17 private methods
func _init_moving_body_parts():
	var path_follow_position := 0.0
	
	_init_moving_body_part(head, path_follow_position)
	path_follow_position += bricks_distance
	
	for body_part in body.get_children():
		_init_moving_body_part(body_part, path_follow_position)
		path_follow_position += bricks_distance
	
	
func _init_moving_body_part(body_part: PhysicsBody2D, path_follow_position: float):
	var path_follow = path_follow_template.duplicate()
	path.add_child(path_follow)
	path_follow.progress = path_follow_position
	body_part.reparent(path_follow)
	body_part.global_position = path_follow.global_position
	
	var moving_body_part = MovingBodyPart.new(body_part, path_follow)
	path_follow_position += bricks_distance
	
	_moving_body_parts.append(moving_body_part)
	
	
func _move_moving_body_parts(delta):
	for moving_body_part in _moving_body_parts:
		moving_body_part.path_follow.progress += speed * delta
#
#
# -- 18 signal listeners
# -- 19 innerclasses

class MovingBodyPart:
	var body_part: PhysicsBody2D
	var path_follow: PathFollow2D
	
	func _init(body_part: PhysicsBody2D, path_follow: PathFollow2D):
		self.body_part = body_part
		self.path_follow = path_follow

