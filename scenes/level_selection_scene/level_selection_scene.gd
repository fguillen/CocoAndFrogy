# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node2D

# -- 04 # docstring
#
# -- 05 signals
signal title_animation_finished()

# -- 06 enums
# -- 07 constants
# -- 08 exported variables
# -- 09 public variables
# -- 10 private variables
var _level_buttons: Array[LevelSelectionButton] 

# -- 11 onready variables
@onready var title_label = %Title
@onready var menu_button = %MenuButton
@onready var buttons = %Buttons



#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	_level_buttons.assign(get_tree().get_nodes_in_group("level_selection_buttons"))
	_show.call_deferred()
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
# -- 17 private methods
func _show():
	_hide_title_label()
	_hide_level_buttons()
	_hide_buttons()
	
	await _animate_title_label()
#	await get_tree().create_timer(1.0).timeout
	await _animate_level_buttons()
	_animate_buttons()
	
	
func _hide_title_label():
	title_label.self_modulate.a = 0.0
	
	
func _hide_level_buttons():
	for level_button in _level_buttons:
		level_button.visible = false
		

func _hide_buttons():
	buttons.modulate.a = 0.0
	
	
func _animate_title_label():
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	var original_position_y = title_label.global_position.y
	tween.tween_property(title_label, "global_position:y", original_position_y, 0.5).from(-375.0)
	tween.parallel().tween_property(title_label, "self_modulate:a", 1.0, 0.5).from(0.0)
	await tween.finished
	title_animation_finished.emit()


func _animate_level_buttons():
	for level_button in _level_buttons:
		level_button.visible = true
		level_button.appear()
		await get_tree().create_timer(0.15).timeout
		

func _animate_buttons():
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	var original_position_y = buttons.global_position.y
	tween.tween_property(buttons, "global_position:y", original_position_y, 0.2).from(get_viewport_rect().size.y + 300)
	tween.parallel().tween_property(buttons, "modulate:a", 1.0, 0.2).from(0.0)
	await tween.finished
	menu_button.grab_focus()
	
	

	
		
# -- 18 signal listeners
# -- 19 subclasses




