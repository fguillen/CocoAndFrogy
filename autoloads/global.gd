# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
signal coco_ready_finished()
signal frogy_ready_finished()

# -- 06 enums
# -- 07 constants
# -- 08 exported variables
# -- 09 public variables
var coco: Coco
var frogy: Frogy
var cleaned_levels: Array[int]
var last_level_played := 0
var lifes := 3


# -- 10 private variables
# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	add_to_group("persist")
	GlobalEvents.level_started.connect(_on_level_started)
	GlobalEvents.level_clear.connect(_on_level_cleared)
	GlobalEvents.game_over.connect(_on_game_over)
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func coco_ready(_coco: Coco):
	self.coco = _coco
	coco_ready_finished.emit()
	

func frogy_ready(_frogy: Frogy):
	self.frogy = _frogy
	frogy_ready_finished.emit()
	
	
func serialize() -> Dictionary:
	return {
		"cleaned_levels": cleaned_levels,
		"last_level_played": last_level_played
	}
	
	
func deserialize(data: Dictionary):
	cleaned_levels.assign(data.cleaned_levels)
	
	
# -- 17 private methods

# -- 18 signal listeners
func _on_level_cleared(level_num: int):
	if not cleaned_levels.has(level_num):
		cleaned_levels.append(level_num)
		DataPersister.save_data()
		
	

func _on_level_started(level_num: int):
	last_level_played = level_num
	DataPersister.save_data()


func _on_game_over():
	lifes = 3	
	
	
# -- 19 subclasses

