# meta-name: Code style template
# meta-description: Empty script with the order of the code sections

# -- 01 @tool
# -- 02 class_name
class_name WalnutBrick
# -- 03 extends
extends Brick

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
# -- 15 remaining built-in virtual methods
# -- 16 public methods
# -- 17 private methods
func _global_signal_emit_brick_freed():
	pass

func _global_signal_emit_brick_ready():
	pass
# -- 18 signal listeners
# -- 19 innerclasses
