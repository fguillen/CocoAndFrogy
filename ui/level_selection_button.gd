# -- 01 @tool
# -- 02 class_name
class_name LevelSelectionButton
# -- 03 extends
extends BaseButton

# -- 04 # docstring
#
# -- 05 signals
signal clicked()
signal clicked_when_locked()

# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var level_num : int


# -- 09 public variables
# -- 10 private variables
var _is_locked := true


# -- 11 onready variables
@onready var lock_sprite = %LockSprite2D

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	pressed.connect(_on_pressed)
	_check_if_unlocked.call_deferred()
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
# -- 17 private methods
func _check_if_unlocked():
	print("XXX: _check_if_unlocked(): ", Global.cleaned_levels, ", level_num: ", level_num)
	if Global.cleaned_levels.find(level_num) != -1:
		_unlock()
	
	
func _unlock():
	print("XXX: _unlock")
	_is_locked = false
	lock_sprite.visible = false
	
	
# -- 18 signal listeners
func _on_pressed():
	if _is_locked:
		clicked_when_locked.emit()
	else:
		clicked.emit()
	
	
	
# -- 19 innerclasses

