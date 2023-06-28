# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node2D

# -- 04 # docstring
#
# -- 05 signals
signal coco_collided_both_walls()
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
# -- 09 public variables
# -- 10 private variables
var _coco
var _coco_wall_collision_right := false
var _coco_wall_collision_left := false

# -- 11 onready variables
@onready var animation_player = $TutorialElements/AnimationPlayer

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	_tutorial()
	_coco = GroupsUtils.coco
	_coco.movement_manager.collision_found.connect(_on_coco_collision)
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
# -- 17 private methods
func _tutorial():
	# Move Coco
	await get_tree().create_timer(1.0).timeout
	animation_player.play("label_move_coco_in")
	await get_tree().create_timer(1.0).timeout
	animation_player.play("finger_side_to_side")
	await coco_collided_both_walls
	animation_player.play_backwards("label_move_coco_in")
	
	# Launch Frogy
	await get_tree().create_timer(1.0).timeout
	animation_player.play("label_launch_frogy_in")
	await get_tree().create_timer(1.0).timeout
	animation_player.play("finger_slide_up")
	await GlobalEvents.frogy_detached
	animation_player.play_backwards("label_launch_frogy_in")


func _on_coco_collision(collision: KinematicCollision2D):
	if collision.get_collider().is_in_group("walls"):
		if _coco.global_position.x > 400:
			_coco_wall_collision_right = true
		else:
			_coco_wall_collision_left = true
			
		if _coco_wall_collision_left and _coco_wall_collision_right:
			coco_collided_both_walls.emit()
	
		
	
# -- 18 signal listeners
# -- 19 innerclasses

