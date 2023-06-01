# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
signal bounced(collision: KinematicCollision2D)
signal bounced_on_coco()
signal bounced_on_brick()
signal bounced_on_other()

# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var character: CharacterBody2D
@export var movement_manager: MovementManager
@export var min_angle := 40.0

# -- 09 public variables
# -- 10 private variables
var _min_angle_rad: float

# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	_min_angle_rad = deg_to_rad(min_angle)
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
# -- 17 private methods
func _filter_flat_direction_angle(direction: Vector2) -> Vector2:
	var result = direction
	
	if direction.angle() < 0 and direction.angle() > -_min_angle_rad:
		result = Vector2.RIGHT.rotated(-_min_angle_rad)
	elif direction.angle() > 0 and direction.angle() < _min_angle_rad:
		result = Vector2.RIGHT.rotated(_min_angle_rad)
	elif direction.angle() > -180 and direction.angle() < -180 - _min_angle_rad:
		result = Vector2.RIGHT.rotated(-180 - _min_angle_rad)
	elif direction.angle() < 180 and direction.angle() > 180 - _min_angle_rad:
		result = Vector2.RIGHT.rotated(180 - _min_angle_rad)
	
	return result
	

func _collision_with_coco(collision: KinematicCollision2D) -> Vector2:
	var normal = collision.get_normal()
	var new_direction := Vector2(movement_manager.direction)
	
	# Collision from the top, most of the cases
	if normal.dot(Vector2.UP) > 0.0:
		# Paddle is moving
		if collision.get_collider().velocity.length() > 0:
			new_direction.y = -new_direction.y
			new_direction.x += collision.get_collider().movement_manager.direction.x * 0.6
			
		# Paddle is no moving
		else:
			## Tilt the normal near the edge
			# Calculate the distance between the collision point and the center of the paddle
			var distance = collision.get_position() - collision.get_collider().global_position
			var amount = distance.x / 193
			normal = normal.rotated(_min_angle_rad * amount)
			new_direction = new_direction.bounce(normal)
			
	else: 
		new_direction = movement_manager.direction.bounce(normal)

	return new_direction
	

func _collision_with_other(collision: KinematicCollision2D) -> Vector2:	
	var normal = collision.get_normal()
	
	return movement_manager.direction.bounce(normal)


# -- 18 signal listeners
func on_collision_found(collision: KinematicCollision2D):
	var direction_result := Vector2.ZERO
	
	if collision.get_collider().is_in_group("coco"):		
		direction_result = _collision_with_coco(collision)
		GlobalEvents.emit_impact_with_coco_occurred()
		GlobalEvents.emit_bounce_performed()
		bounced_on_coco.emit()
		
	elif collision.get_collider().is_in_group("bricks"):
		direction_result = _collision_with_other(collision)
		GlobalEvents.emit_impact_with_brick_occurred()
		GlobalEvents.emit_bounce_performed()
		bounced_on_brick.emit()
		
	elif collision.get_collider().is_in_group("walls"): 
		direction_result = _collision_with_other(collision)
		GlobalEvents.emit_bounce_performed()
		bounced_on_other.emit()
		
	else: 
		return
		
	direction_result = _filter_flat_direction_angle(direction_result)
	movement_manager.direction = direction_result
	bounced.emit(collision)
	
# -- 19 subclasses

