# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends CanvasLayer

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var ui_life_paths: Array[NodePath]
@onready var ui_lifes = ui_life_paths.map(get_node)
@onready var points_label = %Label
@onready var animate_number_effect = $AnimateNumberEffect


# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	GlobalEvents.frogy_died.connect(_remove_life)
	GlobalEvents.score_changed.connect(_on_score_changed)
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
# -- 17 private methods
func _remove_life():
	var ui_lifes_full = ui_lifes.filter(func(e): return e.is_full)
	
	if ui_lifes_full.is_empty():
		push_warning("UI._remove_life: all lifes are empty already")
		return
		
	ui_lifes_full.back().set_empty()
	
	
# -- 18 signal listeners
func _on_score_changed(previous: int, actual: int):
	animate_number_effect.perform(actual)
# -- 19 subclasses

