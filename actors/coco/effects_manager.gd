# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node2D

# -- 04 # docstring
#
# -- 05 signals
signal impact_frogy_coco_ocurred()

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
	GlobalEvents.impact_with_coco_occurred.connect(_on_impact_frogy_coco)
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
# -- 17 private methods
func _on_impact_frogy_coco():
	impact_frogy_coco_ocurred.emit()
	
	
# -- 18 signal listeners
# -- 19 subclasses

