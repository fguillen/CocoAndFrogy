# -- 01 @tool
# -- 02 class_name
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
var _hurt_dissabled := false

# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func impact():
	if not _hurt_dissabled:
		health -= 1
		
	hurt.emit()
	
	if health <= 0:
		_die()
	else:
		animation_state_machine.travel("hurt")
	
		
func animate_hurt():
	animation_state_machine.travel("hurt")
	
	
func dissable_hurt():
	_hurt_dissabled = true
	

func enable_hurt():
	_hurt_dissabled = false
	
# -- 17 private methods
# -- 18 signal listeners
# -- 19 subclasses
