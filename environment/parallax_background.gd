# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends ParallaxBackground

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var scroll_multiplier := -1
# -- 09 public variables
# -- 10 private variables

var _screen_width: int
# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	_screen_width = get_viewport().get_visible_rect().size.x
	
	
# -- 15 remaining built-in virtual methods
func _process(delta):
	_move()
	
	
# -- 16 public methods
# -- 17 private methods
func _move():
	
	var coco = GroupsUtils.coco
	if not coco:
		return
	
	scroll_offset.x = (coco.global_position.x - (_screen_width / 2.0)) * scroll_multiplier	
		
# -- 18 signal listeners
# -- 19 subclasses

