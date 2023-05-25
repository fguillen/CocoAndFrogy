# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
signal death_started()
signal death_finished()


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
	death_started.emit()
	GlobalEvents.emit_frogy_died()
	
	movement_manager.stop()
	collision_shape_2d.disabled = true
	animation_player.play("die")
	
	await animation_player.animation_finished
	
	animation_player.play("RESET")
	print("XXX: RESET ", GroupsUtils.frogy.get_node("Visuals").position)
	
	await animation_player.animation_finished
	
	print("XXX: RESET2 ", GroupsUtils.frogy.get_node("Visuals").position)
	movement_manager.resume()
	movement_manager.reset()
	collision_shape_2d.disabled = false
	
	death_finished.emit()
	
	
# -- 18 signal listeners
func on_collision_found(collision: KinematicCollision2D):
	if collision.get_collider().is_in_group("wall_death"):
		_die()
# -- 19 subclasses

