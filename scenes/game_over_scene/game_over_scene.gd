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
signal go_to_level(level_num: int)

# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var label_paths: Array[NodePath]
@onready var labels = label_paths.map(get_node)

@export var number_paths: Array[NodePath]
@onready var numbers = number_paths.map(get_node)

# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
@onready var title_label = %Title
@onready var retry_button = %RetryButton
@onready var buttons = %Buttons



#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	_show.call_deferred()
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
# -- 17 private methods
func _show():
	_hide_title_label()
	_hide_labels()
	_hide_numbers()
	_hide_buttons()
	
	await _animate_title_label()
	await _animate_labels()
	await _animate_numbers()
	await get_tree().create_timer(1.0).timeout
	
	_animate_buttons()
	
func _hide_title_label():
	title_label.self_modulate.a = 0.0
	
	
func _hide_labels():
	for label in labels:
		label.self_modulate.a = 0.0
		
		
func _hide_numbers():
	for number in numbers:
		number.self_modulate.a = 0.0


func _hide_buttons():
	buttons.modulate.a = 0.0
	

func _animate_title_label():
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	var original_position_y = title_label.global_position.y
	tween.tween_property(title_label, "global_position:y", original_position_y, 0.5).from(-375.0)
	tween.parallel().tween_property(title_label, "self_modulate:a", 1.0, 0.5).from(0.0)
	await tween.finished
	title_animation_finished.emit()
	
		
func _animate_labels():
	for label in labels:
		label.label_show()
		await label.animation_finished
		stats_label_animated.emit()
			
		
func _animate_numbers():	
	for number in numbers:
		number.label_show()
		await number.animation_finished
		stats_number_animated.emit()


func _animate_buttons():
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	var original_position_y = buttons.global_position.y
	tween.tween_property(buttons, "global_position:y", original_position_y, 0.2).from(get_viewport_rect().size.y + 300)
	tween.parallel().tween_property(buttons, "modulate:a", 1.0, 0.2).from(0.0)
	await tween.finished
	retry_button.grab_focus()
	
		
# -- 18 signal listeners
func _on_retry_button_pressed():
	StatsManager.reset_total_score()
	go_to_level.emit(Global.last_level_played)
	
	
# -- 19 subclasses







