# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node2D

# -- 04 # docstring
#
# -- 05 signals
signal stats_animated()

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
	await _animate_labels()
	_animate_numbers()
	
	
func _hide_labels():
	for label in labels:
		label.self_modulate.a = 0.0
		
		
func _hide_numbers():
	for number in numbers:
		number.self_modulate.a = 0.0
		
		
func _animate_labels():
	var tween = get_tree().create_tween()
	
	for label in labels:
		tween.tween_callback(label.label_show)
		tween.tween_interval(0.25)
		
	await tween.finished
		
		
func _animate_numbers():	
	for number in numbers:
		number.label_show(1000)
		await number.animation_finished
		
		
# -- 18 signal listeners
# -- 19 subclasses

