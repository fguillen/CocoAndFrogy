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
@export var node_visuals: Node2D

# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func perform():
	node_visuals.visible = false
	
	var coco: Coco = GroupsUtils.coco
	if not coco.frogy_handler:
		await Global.coco_ready_finished
		coco = GroupsUtils.coco
	
	GroupsUtils.frogy.attached_to(GroupsUtils.coco.frogy_handler)
	
	animation_player.play("show")

	
func show_visuals():
	node_visuals.visible = true
	
# -- 17 private methods
# -- 18 signal listeners
# -- 19 subclasses

