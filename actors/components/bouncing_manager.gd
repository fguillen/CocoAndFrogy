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
	print("XXX: collision: ", collision.get_collider().get_groups())
	var normal = collision.get_normal()
	
	if collision.get_collider().is_in_group("coco"):		
		# Collision from the top, most of the cases
		if normal.dot(Vector2.UP) > 0.0:
			movement_manager.direction = Vector2(movement_manager.direction.x, -movement_manager.direction.y)
	
	else: 
		movement_manager.direction = movement_manager.direction.bounce(normal)
# -- 19 subclasses

