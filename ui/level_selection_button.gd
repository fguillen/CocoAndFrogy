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
signal clicked_with_pause()
signal just_appeared()


# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var level_num : int


# -- 09 public variables
# -- 10 private variables
var _is_locked := true


# -- 11 onready variables
@onready var character_sprite_01 = %CharacterSprite01
@onready var character_sprite_02 = %CharacterSprite02
@onready var lock_sprite = %LockSprite2D

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	pressed.connect(_on_pressed)
	character_sprite_01.visible = false
	character_sprite_02.visible = false
	
	_check_if_unlocked.call_deferred()
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func appear():
	scale = Vector2.ZERO
	just_appeared.emit()
	
	
# -- 17 private methods
func _check_if_unlocked():
	print("XXX: _check_if_unlocked(): ", Global.cleaned_levels, ", level_num: ", level_num)
	
	# Level 00 always unlocked
	if (level_num == 0) or (Global.cleaned_levels.find(level_num - 1) != -1):
		_unlock()
	
	
func _unlock():
	print("XXX: _unlock")
	_is_locked = false
	lock_sprite.visible = false
	character_sprite_01.visible = true
	character_sprite_02.visible = true
	
	
# -- 18 signal listeners
func _on_pressed():
	if _is_locked:
		clicked_when_locked.emit()
	else:
		clicked.emit()
		await get_tree().create_timer(0.4).timeout
		clicked_with_pause.emit()
	
	
	
# -- 19 innerclasses

