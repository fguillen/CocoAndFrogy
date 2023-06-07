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
@export var rejoin_speed := 500.0

@export_group("Path")
@export var path: Path2D
@export var path_follow_template: PathFollow2D


# -- 09 public variables
# -- 10 private variables
var _moving_body_parts: Array[MovingBodyPart]

# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	head.dissable_hurt()
	
	_init_moving_body_parts()
	
	
# -- 15 remaining built-in virtual methods
func _physics_process(delta):
	_move_moving_body_parts(delta)
	_rejoin_moving_body_parts(delta)
	
	
# -- 16 public methods
# -- 17 private methods
func _init_moving_body_parts():
	var path_follow_position := body.get_child_count() * bricks_distance
	
	_init_moving_body_part(head, path_follow_position)
	path_follow_position -= bricks_distance
	
	for body_part in body.get_children():
		_init_moving_body_part(body_part, path_follow_position)
		path_follow_position -= bricks_distance
	
	
func _init_moving_body_part(body_part: PhysicsBody2D, path_follow_position: float):
	var path_follow = path_follow_template.duplicate()
	path.add_child(path_follow)
	path_follow.progress = path_follow_position
#	body_part.reparent(path_follow)
#	body_part.global_position = path_follow.global_position
	body_part.hurt.connect(head.animate_hurt)
	
	var moving_body_part = MovingBodyPart.new(body_part, path_follow)
	path_follow_position += bricks_distance
	
	body_part.tree_exited.connect(_on_body_part_queued.bind(moving_body_part))
	_moving_body_parts.append(moving_body_part)
	
	
func _move_moving_body_parts(delta):
	for moving_body_part in _moving_body_parts:
		moving_body_part.path_follow.progress += speed * delta
#		moving_body_part.body_part.global_position = moving_body_part.path_follow.global_position
		var movement = moving_body_part.path_follow.global_position - moving_body_part.body_part.global_position
		moving_body_part.body_part.move_and_collide(movement)


func _rejoin_moving_body_parts(delta):
	if _moving_body_parts.size() < 2:
		return 
		
	var previous_moving_body_part = _moving_body_parts[0]
	
	for moving_body_part in _moving_body_parts.slice(1):
		moving_body_part = moving_body_part as MovingBodyPart
		var distance = previous_moving_body_part.path_follow.progress - moving_body_part.path_follow.progress
		if(distance > bricks_distance):
			_rejoin_moving_body_part(moving_body_part, distance, delta)
			
		previous_moving_body_part = moving_body_part
			

func _rejoin_moving_body_part(moving_body_part_ini, distance, delta):
	var index = _moving_body_parts.find(moving_body_part_ini)
	var rejoin_movement = min(distance, rejoin_speed * delta)
	for moving_body_part in _moving_body_parts.slice(index):
		moving_body_part.path_follow.progress += rejoin_movement
		
		
func _remove_moving_body_part(moving_body_part: MovingBodyPart):
	_moving_body_parts.erase(moving_body_part)
	
	if _moving_body_parts.size() <= 1:
		head.enable_hurt()
		

# -- 18 signal listeners
func _on_body_part_queued(moving_body_part: MovingBodyPart):
	_remove_moving_body_part(moving_body_part)
	
# -- 19 innerclasses

class MovingBodyPart:
	var body_part: PhysicsBody2D
	var path_follow: PathFollow2D
	
	func _init(body_part: PhysicsBody2D, path_follow: PathFollow2D):
		self.body_part = body_part
		self.path_follow = path_follow
		

