# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node2D

# -- 04 # docstring
#
# -- 05 signals
signal stats_number_animated()
signal stats_label_animated()
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
var _is_still_animating := true
var _tweens_speed := 1.0


# -- 11 onready variables
@onready var stats_title_label = %StatsTitle
@onready var next_button = %NextButton


#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	_show.call_deferred()
	
	
# -- 15 remaining built-in virtual methods
func _input(event):
	if event.is_action_pressed("ui_accept") and _is_still_animating:
		_accelerate()
		
	
# -- 16 public methods
func next():
	go_to_level.emit(Global.last_level_played + 1)
	
	
# -- 17 private methods
func _show():
	_hide_stats_title_label()
	_hide_labels()
	_hide_numbers()
	_hide_next_button()
	
	await _animate_stats_title_label()
	await _animate_labels()
	await _animate_numbers()
	await get_tree().create_timer(1.0).timeout
	
	_animate_next_button()
	
	_is_still_animating = false
	
	
func _hide_stats_title_label():
	stats_title_label.self_modulate.a = 0.0
	
	
func _hide_labels():
	for label in labels:
		label.self_modulate.a = 0.0
		
		
func _hide_numbers():
	for number in numbers:
		number.self_modulate.a = 0.0


func _hide_next_button():
	next_button.self_modulate.a = 0.0
	

func _animate_stats_title_label():
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC).set_speed_scale(_tweens_speed)
	var original_position_y = stats_title_label.global_position.y
	tween.tween_property(stats_title_label, "global_position:y", original_position_y, 0.2).from(-375.0)
	tween.parallel().tween_property(stats_title_label, "self_modulate:a", 1.0, 0.2).from(0.0)
	await tween.finished
	
		
func _animate_labels():
	for label in labels:
		label.label_show(_tweens_speed)
		await label.animation_finished
		stats_label_animated.emit()
			
		
func _animate_numbers():	
	for number in numbers:
		number.label_show(_tweens_speed)
		await number.animation_finished
		stats_number_animated.emit()


func _animate_next_button():
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC).set_speed_scale(_tweens_speed)
	var original_position_y = next_button.global_position.y
	tween.tween_property(next_button, "global_position:y", original_position_y, 0.2).from(get_viewport_rect().size.y + 300)
	tween.parallel().tween_property(next_button, "self_modulate:a", 1.0, 0.2).from(0.0)
	await tween.finished
	next_button.grab_focus()


func _accelerate():
	print("XXX: StatsScene._accelerate()")
	_tweens_speed = 5.0

		
# -- 18 signal listeners
# -- 19 subclasses

