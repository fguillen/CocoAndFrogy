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
# -- 11 onready variables
@onready var title_label = %Title
@onready var play_button = %PlayButton
@onready var buttons = %Buttons
@onready var music_slider = %MusicSlider
@onready var sfx_slider = %SFXSlider



#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	_show.call_deferred()
	_update_display()
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
# -- 17 private methods
func _show():
	_hide_title_label()
	_hide_buttons()
	
	await _animate_title_label()
	await get_tree().create_timer(1.0).timeout
	
	_animate_buttons()
	
func _hide_title_label():
	title_label.self_modulate.a = 0.0
	

func _hide_buttons():
	buttons.modulate.a = 0.0
	

func _animate_title_label():
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	var original_position_y = title_label.global_position.y
	tween.tween_property(title_label, "global_position:y", original_position_y, 0.5).from(-375.0)
	tween.parallel().tween_property(title_label, "self_modulate:a", 1.0, 0.5).from(0.0)
	await tween.finished
	title_animation_finished.emit()


func _animate_buttons():
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	var original_position_y = buttons.global_position.y
	tween.tween_property(buttons, "global_position:y", original_position_y, 0.2).from(get_viewport_rect().size.y + 300)
	tween.parallel().tween_property(buttons, "modulate:a", 1.0, 0.2).from(0.0)
	await tween.finished
	play_button.grab_focus()
	
	
func _update_display():
	music_slider.value = GlobalOptionsManager.get_volume_music()
	sfx_slider.value = GlobalOptionsManager.get_volume_sfx()
	
		
# -- 18 signal listeners
func _on_sfx_slider_value_changed(value):
	GlobalOptionsManager.set_volume_sfx(value)


func _on_music_slider_value_changed(value):
	GlobalOptionsManager.set_volume_music(value)

# -- 19 subclasses


