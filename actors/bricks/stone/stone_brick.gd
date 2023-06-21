# -- 01 @tool
# -- 02 class_name
class_name StoneBrick
# -- 03 extends
extends Brick

# -- 04 # docstring
#
# -- 05 signals
signal not_enough_speed_impacted()
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
# -- 09 public variables
# -- 10 private variables
var _frogy_minimum_speed_to_cause_hurt := 1200
var _sprite_frame := 0

# -- 11 onready variables
@onready var sprite = $Visuals/Sprite2D

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func impact():
	if not _is_frogy_fast_enough_to_produce_hurt():
		not_enough_speed_impacted.emit()
		return
		
	health -= 1
	hurt.emit()
	
	if health <= 0:
		_die()
	else:
		_increase_sprite_frame()
		animation_state_machine.travel("hurt")
		
		
# -- 17 private methods
func _is_frogy_fast_enough_to_produce_hurt() -> bool:
	var frogy := GroupsUtils.frogy
	if not frogy:
		push_error("Not frogy found")
		return false
	
	var frogy_speed = frogy.movement_manager.speed
	var result = frogy_speed >= _frogy_minimum_speed_to_cause_hurt
	print("XXX: frogy_speed: %d, result: %s" % [frogy_speed, result])
	return result
	

func _increase_sprite_frame():
	_sprite_frame += 1
	sprite.frame = _sprite_frame
	
# -- 18 signal listeners
# -- 19 innerclasses

