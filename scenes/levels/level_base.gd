# -- 01 @tool
# -- 02 class_name
class_name Level
# -- 03 extends
extends Node2D

# -- 04 # docstring
#
# -- 05 signals
signal level_cleared()
signal game_over()
signal level_finishing()


# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var level_num: int
@export var music: AudioStream


# -- 09 public variables
var bricks: Array[Brick]

# -- 10 private variables
# -- 11 onready variables
@onready var background_music = $Effects/BackgroundMusic

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	GlobalEvents.brick_ready.connect(_add_brick)
	GlobalEvents.brick_freed.connect(_remove_brick)
	GlobalEvents.frogy_died.connect(_remove_life)
	
	GlobalEvents.emit_level_started(level_num)
	
	background_music.stream = music
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func set_level_cleared():
	GlobalEvents.emit_level_clear(level_num)
	level_cleared.emit()
	
# -- 17 private methods
func _add_brick(brick: Brick):
	bricks.append(brick)


func _remove_brick(brick: Brick):
	bricks.erase(brick)
	
	if bricks.is_empty():
		level_finishing.emit()
		await get_tree().create_timer(0.5).timeout
		set_level_cleared()
		
		
func _remove_life():
	if Global.is_lifes_empty():
		GlobalEvents.emit_game_over()
		level_finishing.emit()
		await get_tree().create_timer(0.5).timeout
		game_over.emit()
	else:
		Global.remove_life()	

# -- 18 signal listeners
# -- 19 subclasses

