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
@export var max_speed := 150.0
@export var speed := 100.0 : set = _set_speed
@export var acceleration := 50
@export var infinite_acceleration := false
@export var decceleration := 80
@export var infinite_decceleration := false
@export var character: CharacterBody2D
@export_enum("Slide", "Collide") var collision_mode: String = "Slide" 


# -- 09 public variables
var direction := Vector2.ZERO : set = _set_direction
var initial_speed: float

# -- 10 private variables
var _stoped := false

# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	initial_speed = speed
	
	
# -- 15 remaining built-in virtual methods
func _physics_process(delta):
	if _stoped: 
		return
		
	_accelerate_deccelerate(delta)
	_move(delta)
			
	
# -- 16 public methods
func stop():
	_stoped = true
	
	
func resume():
	_stoped = false
	

func reset():
	speed = initial_speed
	
	
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
		# print("MovementManager.direction_changed: ", previous_direction, ", ", direction)
		direction_changed.emit(direction)


func _set_speed(value: float):
	if value > max_speed:
		print("MovememtManager._set_speed() clamped %d -> %d" % [value, max_speed])
		
	speed = min(value, max_speed)
	
		
# -- 18 signal listeners
func on_direction_changed(new_direction: Vector2):
	direction = new_direction

# -- 19 subclasses

