# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
signal coco_ready_finished()
signal frogy_ready_finished()

# -- 06 enums
# -- 07 constants
# -- 08 exported variables
# -- 09 public variables
var coco: Coco
var frogy: Frogy

# -- 10 private variables
# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func coco_ready(_coco: Coco):
	self.coco = _coco
	coco_ready_finished.emit()
	

func frogy_ready(_frogy: Frogy):
	self.frogy = _frogy
	frogy_ready_finished.emit()
	
	
# -- 17 private methods
# -- 18 signal listeners
# -- 19 subclasses

