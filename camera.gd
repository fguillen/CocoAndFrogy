# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Camera2D

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
@onready var shake_effect: ShakeEffect = $Effects/ShakeEffect

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	GlobalEvents.impact_with_coco_occurred.connect(shake_soft)
	GlobalEvents.impact_with_brick_occurred.connect(shake_medium)
	GlobalEvents.frogy_died.connect(shake_strong)
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func shake_soft():
	shake_effect.perform(0.2, 100, 0.5)
	
	
func shake_medium():
	shake_effect.perform(0.4, 100, 0.8)
	
	
func shake_strong():
	shake_effect.perform(1, 20, 1.0)

# -- 17 private methods
# -- 18 signal listeners
# -- 19 subclasses

