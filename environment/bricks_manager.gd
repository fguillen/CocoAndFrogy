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
# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	_show_bricks()
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
# -- 17 private methods
func _show_bricks():
	var bricks = get_tree().get_nodes_in_group("bricks")
	
	for brick in bricks:
		brick.auto_start = false
		brick.visible = false
		
	var tween = create_tween()
	for brick in bricks:
		tween.tween_callback(_show_brick.bind(brick))
		tween.tween_interval(0.1)


func _show_brick(brick: Brick):
	brick.visible = true	
	brick.start()
	
		
# -- 18 signal listeners
# -- 19 subclasses

