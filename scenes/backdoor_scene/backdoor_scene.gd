# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node2D

# -- 04 # docstring
#
# -- 05 signals
signal title_animation_finished()
signal go_to_end_scene()

# -- 06 enums
# -- 07 constants
const PASSWORD = "cocococo"
# -- 08 exported variables
# -- 09 public variables
# -- 10 private variables
var _options_shown := false

# -- 11 onready variables
@onready var title_label = %Title
@onready var menu_button = %MenuButton
@onready var buttons = %Buttons
@onready var password_line_edit:LineEdit = %PasswordLineEdit
@onready var body_password = %BodyPassword
@onready var body = %Body



#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	body.visible = false
	body.process_mode = Node.PROCESS_MODE_DISABLED
	
	_show.call_deferred()
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func clear_all_levels():
	Global.mark_all_levels_as_cleared()
	

func see_end_scene():
	Global.see_final_scene_backdoor = true
	go_to_end_scene.emit()
	
	
func immunity(value: bool):
	Global.immunity = value
	
	
func password_changed(value: String):
	if value == PASSWORD:
		_show_options()
	
	
# -- 17 private methods
func _show():
	_hide_title_label()
	_hide_buttons()
	
	await _animate_title_label()
#	await get_tree().create_timer(1.0).timeout
	
	_animate_buttons()
	
func _hide_title_label():
	title_label.self_modulate.a = 0.0
	

func _hide_buttons():
	buttons.modulate.a = 0.0
	

func _animate_title_label():
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	var original_position_y = title_label.global_position.y
	tween.tween_property(title_label, "global_position:y", original_position_y, 0.5).from(-375.0)
	tween.parallel().tween_property(title_label, "self_modulate:a", 1.0, 0.5).from(0.0)
	await tween.finished
	title_animation_finished.emit()


func _animate_buttons():
	var tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	var original_position_y = buttons.global_position.y
	tween.tween_property(buttons, "global_position:y", original_position_y, 0.2).from(get_viewport_rect().size.y + 300)
	tween.parallel().tween_property(buttons, "modulate:a", 1.0, 0.2).from(0.0)
	await tween.finished
	menu_button.grab_focus()
	
	
func _show_options():
	if _options_shown:
		return
		
	_options_shown = true	
	body_password.queue_free()
	body.visible = true
	body.process_mode = Node.PROCESS_MODE_INHERIT
	
		
# -- 18 signal listeners
# -- 19 subclasses


