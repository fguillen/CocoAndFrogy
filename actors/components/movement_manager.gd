# -- 01 @tool
# -- 02 class_name
class_name MovementManager
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
signal direction_changed(direction: Vector2)
signal collision_found(collision: KinematicCollision2D)

# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var speed := 100
@export var acceleration := 50
@export var infinite_acceleration := false
@export var decceleration := 80
@export var infinite_decceleration := false
@export var character: CharacterBody2D
@export_enum("Slide", "Collide") var collision_mode: String = "Slide" 


# -- 09 public variables
var direction := Vector2.ZERO : set = _set_direction


# -- 10 private variables
# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
func _physics_process(delta):
	_accelerate_deccelerate(delta)
	_move(delta)
			
	
# -- 16 public methods
# -- 17 private methods
func _accelerate_deccelerate(delta: float):
	var desired_velocity = speed * direction
	
	# If moving
	if desired_velocity != Vector2.ZERO:
		if infinite_acceleration:
			character.velocity = desired_velocity
		else:
			character.velocity = character.velocity.move_toward(desired_velocity, acceleration * delta)
			
	# If no moving
	else: 
		if infinite_decceleration:
			character.velocity = desired_velocity
		else:
			character.velocity = character.velocity.move_toward(desired_velocity, decceleration * delta)


func _move(delta):
	if collision_mode == "Slide":
		character.move_and_slide()
	else:
		var collision = character.move_and_collide(character.velocity * delta)
		if collision:
			collision_found.emit(collision)
			
			
func _set_direction(value: Vector2):
	var previous_direction = Vector2(direction)
	direction = value.normalized()
	
	if previous_direction != direction:
		print("MovementManager.direction_changed: ", previous_direction, ", ", direction)
		direction_changed.emit(direction)
		
# -- 18 signal listeners
# -- 19 subclasses

