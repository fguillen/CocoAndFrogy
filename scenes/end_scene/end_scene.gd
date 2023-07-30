# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node2D

# -- 04 # docstring
#
# -- 05 signals
signal title_animation_finished()
signal stats_label_animated()
signal stats_number_animated()
signal end_scene_visible()
signal end_scene_no_visible()

# -- 06 enums
# -- 07 constants
# -- 08 exported variables
# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
@onready var title_label = %Title
@onready var back_to_menu_button = %BackToMenuButton
@onready var buttons = %Buttons
@onready var total_score_title = %TotalScoreTitle
@onready var total_score_number = %TotalScoreNumber
@onready var title_animation = %Title/TitleAnimation
@onready var title_no_end_scene_visibles = %Title/TitleNoEndSceneVisibles
@onready var no_end_scene_visible = %NoEndSceneVisible
@onready var end_animation = %EndAnimation
@onready var body = %Body
@onready var body_label = %Body/Label
@onready var quit_button = %QuitButton

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	_show.call_deferred()
	
	if OS.get_name() == "iOS":
		quit_button.queue_free()
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
# -- 17 private methods
func _show():
	_hide_title_label()
	_hide_body()
	_hide_buttons()
	
	_setup_end_animation_visible()

	await _animate_title_label()
	await _animate_body()
	await _animate_buttons()
	
	if Global.has_finished_all_leveles_in_a_row():
		end_scene_visible.emit()
	else:
		end_scene_no_visible.emit()
		
	# Reset this in case was active
	Global.see_final_scene_backdoor = false
	
	
func _hide_title_label():
	title_label.modulate.a = 0.0
	
	
func _hide_body():
	body.modulate.a = 0.0
	

func _hide_buttons():
	buttons.modulate.a = 0.0
	total_score_title.self_modulate.a = 0.0
	total_score_number.self_modulate.a = 0.0
	

func _animate_title_label():
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	var original_position_y = title_label.global_position.y
	tween.tween_property(title_label, "global_position:y", original_position_y, 0.5).from(-375.0)
	tween.parallel().tween_property(title_label, "modulate:a", 1.0, 0.5).from(0.0)
	await tween.finished
	title_animation_finished.emit()


func _animate_body():
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	var original_position_x = body.global_position.x
	tween.tween_property(body, "global_position:x", original_position_x, 0.5).from(get_viewport_rect().size.x  + 500.0)
	tween.parallel().tween_property(body, "modulate:a", 1.0, 0.5).from(0.0)
	await tween.finished


func _animate_buttons():
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	var original_position_y = buttons.global_position.y
	tween.tween_property(buttons, "global_position:y", original_position_y, 0.5).from(get_viewport_rect().size.y + 300)
	tween.parallel().tween_property(buttons, "modulate:a", 1.0, 0.5).from(0.0)
	await tween.finished
	
	back_to_menu_button.grab_focus()
	
	total_score_title.label_show()
	await total_score_title.animation_finished
	stats_label_animated.emit()
	
	total_score_number.label_show()
	await total_score_number.animation_finished
	stats_number_animated.emit()
	
	
func _setup_end_animation_visible():
	if Global.has_finished_all_leveles_in_a_row():
		title_animation.visible = true
		title_no_end_scene_visibles.visible = false
		no_end_scene_visible.visible = false
		no_end_scene_visible.process_mode = Node.PROCESS_MODE_DISABLED
		end_animation.visible = true
		body_label.visible = false
	else:
		title_animation.visible = false
		title_no_end_scene_visibles.visible = true
		no_end_scene_visible.visible = true
		end_animation.process_mode = Node.PROCESS_MODE_DISABLED
		end_animation.visible = false
		body_label.visible = true
		
		
# -- 18 signal listeners
# -- 19 subclasses




