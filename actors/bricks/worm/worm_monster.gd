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
@export var bricks_distance := 200.0

@export_group("Path")
@export var path: Path2D


# -- 09 public variables
# -- 10 private variables
var _moving_bricks: Array[MovingBrick]
var _actual_position := 0.0

# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	_init_moving_bricks()
	
	
# -- 15 remaining built-in virtual methods
func _physics_process(delta):
	_move_moving_bricks(delta)
	
	
# -- 16 public methods
# -- 17 private methods
func _init_moving_bricks():
	var path_follow_position := 0.0
	
	for brick in body.get_children():
		var path_follow = PathFollow2D.new()
		path.add_child(path_follow)
		path_follow.progress = path_follow_position
		path_follow.rotates = false
		
		var moving_brick = MovingBrick.new(brick, path_follow)
		path_follow_position += bricks_distance
		
		_moving_bricks.append(moving_brick)
		
	
func _move_moving_bricks(delta):
	for moving_brick in _moving_bricks:
		moving_brick.path_follow.progress += speed * delta
		var brick_direction = moving_brick.brick.global_position.direction_to(moving_brick.path_follow.global_position)
		moving_brick.brick.move_and_collide(brick_direction * speed)
		
	
# -- 18 signal listeners
# -- 19 innerclasses

class MovingBrick:
	var brick: Brick
	var path_follow: PathFollow2D
	
	func _init(brick: Brick, path_follow: PathFollow2D):
		self.brick = brick
		self.path_follow = path_follow

