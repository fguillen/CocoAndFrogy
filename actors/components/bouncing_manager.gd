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
@export var character: CharacterBody2D
@export var movement_manager: MovementManager
@export var max_normal_angle: float = 15.0

# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
# -- 16 public methods
# -- 17 private methods
# -- 18 signal listeners
func on_collision_found(collision: KinematicCollision2D):
	var normal = collision.get_normal()
	
	if collision.get_collider().is_in_group("coco"):		
		# Collision from the top, most of the cases
		if normal.dot(Vector2.UP) > 0.0:
			var new_direction := Vector2(movement_manager.direction)
											
			# Paddle is moving
			if collision.get_collider().velocity.length() > 0:
				new_direction.y = -new_direction.y
				new_direction.x += collision.get_collider().movement_manager.direction.x * 0.6
				
			else:
				## Tilt the normal near the edge
				# Calculate the distance between the collision point and the center of the paddle
				var distance = collision.get_position() - collision.get_collider().global_position
				var amount = distance.x / 193
				normal = normal.rotated(deg_to_rad(max_normal_angle) * amount)
				new_direction = new_direction.bounce(normal)
				
			movement_manager.direction = new_direction
	
	else: 
		movement_manager.direction = movement_manager.direction.bounce(normal)
# -- 19 subclasses

