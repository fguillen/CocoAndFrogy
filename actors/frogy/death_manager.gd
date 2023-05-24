# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
signal death()


# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var movement_manager: MovementManager
@export var collision_shape_2d: CollisionShape2D
@export var animation_player: AnimationPlayer


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
func _die():
	print("DeathManager._die()")
	movement_manager.stop()
	collision_shape_2d.disabled = true
	animation_player.play("die")
	
	await get_tree().create_timer(2).timeout
	death.emit()
	
# -- 18 signal listeners
func on_collision_found(collision: KinematicCollision2D):
	if collision.get_collider().is_in_group("wall_death"):
		_die()
# -- 19 subclasses
