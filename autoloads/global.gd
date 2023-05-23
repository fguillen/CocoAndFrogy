# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
# -- 09 public variables
var coco: Coco
var frogy: Frogy

# -- 10 private variables
var _is_frogy_set := false

# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func coco_ready(_coco: Coco):
	self.coco = _coco
	_check_if_setup_frogy()
	

func frogy_ready(_frogy: Frogy):
	self.frogy = _frogy
	_check_if_setup_frogy()
	
	
# -- 17 private methods
func _check_if_setup_frogy():
	if coco and frogy and not _is_frogy_set:
		frogy.attached_to(coco.frogy_handler)
		
# -- 18 signal listeners
# -- 19 subclasses

