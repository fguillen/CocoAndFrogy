# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node2D

# -- 04 # docstring
#
# -- 05 signals
signal stats_number_animated()

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
@onready var stats_title_label = %StatsTitle
@onready var next_button = %NextButton


#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	_animate.call_deferred()
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
# -- 17 private methods
func _animate():
	_hide_labels()
	_hide_numbers()
	_hide_next_button()
	
	await _animate_stats_title_label()
	await _animate_labels()
	await _animate_numbers()
	await get_tree().create_timer(1.0).timeout
	
	_animate_next_button()
	
	
func _hide_labels():
	for label in labels:
		label.self_modulate.a = 0.0
		
		
func _hide_numbers():
	for number in numbers:
		number.self_modulate.a = 0.0


func _hide_next_button():
	next_button.self_modulate.a = 0.0
	

func _animate_stats_title_label():
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	var original_position_y = stats_title_label.global_position.y
	tween.tween_property(stats_title_label, "global_position:y", original_position_y, 0.2).from(-375.0)
	await tween.finished
	
		
func _animate_labels():
	for label in labels:
		label.label_show()
		await label.animation_finished
			
		
func _animate_numbers():	
	for number in numbers:
		number.label_show(1000)
		await number.animation_finished
		stats_number_animated.emit()


func _animate_next_button():
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	var original_position_y = next_button.global_position.y
	tween.tween_property(next_button, "global_position:y", original_position_y, 0.2).from(get_viewport_rect().size.y + 300)
	tween.parallel().tween_property(next_button, "self_modulate:a", 1.0, 0.2).from(0.0)
	await tween.finished
		
# -- 18 signal listeners
# -- 19 subclasses

