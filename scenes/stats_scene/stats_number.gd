# -- 01 @tool
# -- 02 class_name
class_name StatsNumber
# -- 03 extends
extends Label

# -- 04 # docstring
#
# -- 05 signals
signal animation_finished()

# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var stats_property: String

# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
@onready var animate_number_effect : AnimateNumberEffect = $Effects/AnimateNumberEffect

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func label_hide():
	self_modulate.a = 0.0
	
	
func label_show():
	var value = StatsManager.get_stat_by_name(stats_property)
	
	var original_position_x = position.x
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "position:x", original_position_x, 0.25).from(get_viewport_rect().size.x)
	tween.parallel().tween_property(self, "self_modulate:a", 1.0, 0.25).from(0.0)
	await tween.finished
	animate_number_effect.perform(value)
	await animate_number_effect.finished
	animation_finished.emit()
	


	
# -- 17 private methods
# -- 18 signal listeners
# -- 19 subclasses

