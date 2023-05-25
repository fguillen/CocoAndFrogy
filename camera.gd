# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Camera2D

# -- 04 # docstring
#
# -- 05 signals
signal shaked(trauma: float)
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
	GlobalEvents.strong_impact_occurred.connect()
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func shake(trauma: float): # Between 0.0 and 1.0
	shaked.emit(trauma)

# -- 17 private methods
# -- 18 signal listeners
# -- 19 subclasses

