# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
signal level_cleared()
signal game_over()


# -- 06 enums
# -- 07 constants
# -- 08 exported variables
# -- 09 public variables
var bricks: Array[Brick]

# -- 10 private variables
var _lifes := 3

# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	GlobalEvents.brick_ready.connect(_add_brick)
	GlobalEvents.brick_queued.connect(_remove_brick)
	GlobalEvents.frogy_died.connect(_remove_life)
	
	GlobalEvents.emit_level_started()
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
# -- 17 private methods
func _add_brick(brick: Brick):
	bricks.append(brick)


func _remove_brick(brick: Brick):
	bricks.erase(brick)
	
	if bricks.is_empty():
		GlobalEvents.emit_level_clear()
		await get_tree().create_timer(0.5).timeout
		level_cleared.emit()
		SceneSwitcher.switch_to("stats_scene/stats_scene")
		
		
func _remove_life():
	_lifes -= 1
	
	if _lifes <= 0:
		GlobalEvents.emit_game_over()
		await get_tree().create_timer(0.5).timeout
		game_over.emit()
		SceneSwitcher.switch_to("game_over_scene/game_over_scene")
		
		

# -- 18 signal listeners
# -- 19 subclasses
