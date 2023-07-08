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
var _step_bump_frogy := false
var _label_make_perfect_visible := false

# -- 11 onready variables
@onready var animation_player = $TutorialElements/AnimationPlayer
@onready var animation_player_fingers = $TutorialElements/AnimationPlayerFingers
@onready var finger_sprite = $TutorialElements/FingerSprite

@onready var level_base = $LevelBase


#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	_tutorial()
	_coco = GroupsUtils.coco
	_coco.bump_manager.disabled = true
	_coco.movement_manager.collision_found.connect(_on_coco_collision)
	
	GlobalEvents.bump_early_performed.connect(_on_no_perfect_bump)
	GlobalEvents.bump_late_performed.connect(_on_no_perfect_bump)
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
# -- 17 private methods
func _tutorial():
	# Move Coco
	await get_tree().create_timer(1.0).timeout
	animation_player.play("label_move_coco_in")
	await get_tree().create_timer(1.0).timeout
	animation_player_fingers.play("finger_side_to_side")
	await coco_collided_both_walls
	animation_player_fingers.stop()
	finger_sprite.visible = false	
	animation_player.play_backwards("label_move_coco_in")
	
	# Launch Frogy
	await get_tree().create_timer(2.0).timeout
	animation_player.play("label_launch_frogy_in")
	await get_tree().create_timer(1.0).timeout
	animation_player_fingers.play("finger_slide_up")
	_coco.bump_manager.disabled = false
	await GlobalEvents.frogy_detached
	animation_player_fingers.stop()
	finger_sprite.visible = false
	animation_player.play_backwards("label_launch_frogy_in")
	
	# Bump Frogy
	await get_tree().create_timer(2.0).timeout
	animation_player.play("label_bump_frogy_in")
	await get_tree().create_timer(1.0).timeout
	animation_player_fingers.play("finger_slide_up")
	_step_bump_frogy = true
	await GlobalEvents.bump_perfect_performed
	animation_player_fingers.stop()
	finger_sprite.visible = false
	_step_bump_frogy = false
	if _label_make_perfect_visible:
		animation_player.play_backwards("label_make_perfect_in")
		await animation_player.animation_finished
	
	animation_player.play_backwards("label_bump_frogy_in")
	
	# Kick Bugs
	await get_tree().create_timer(2.0).timeout
	animation_player.play("label_kick_bugs_in")
	await get_tree().create_timer(3.0).timeout
	level_base.set_level_cleared()


func _on_coco_collision(collision: KinematicCollision2D):
	if collision.get_collider().is_in_group("walls"):
		if _coco.global_position.x > 400:
			_coco_wall_collision_right = true
		else:
			_coco_wall_collision_left = true
			
		if _coco_wall_collision_left and _coco_wall_collision_right:
			coco_collided_both_walls.emit()
	

func _on_no_perfect_bump():
	if _step_bump_frogy and not _label_make_perfect_visible:
		animation_player.play("label_make_perfect_in")
		_label_make_perfect_visible = true
	
# -- 18 signal listeners
# -- 19 innerclasses

