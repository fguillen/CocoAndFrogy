# -- 01 @tool
# -- 02 class_name
class_name NavigationManager

# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
# -- 09 public variables
# -- 10 private variables
var _scenes = {
	"menu": "res://scenes/menu_scene/menu_scene.tscn",
	"options": "res://scenes/options_scene/options_scene.tscn",
	"levels": "",
	"credits": "",
	"level_01": "res://scenes/levels/level_01.tscn",
	"level_02": "res://scenes/levels/level_02.tscn",
	"level_03": "res://scenes/levels/level_03.tscn",
	"level_04": "res://scenes/levels/level_04.tscn",
	"level_05": "res://scenes/levels/level_05.tscn",
	"stats": "res://scenes/stats_scene/stats_scene.tscn",
	"game_over": "res://scenes/game_over_scene/game_over_scene.tscn",
	"end": "",
}

# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func go_to(name: String):
	SceneSwitcher.switch_to(_scenes[name])
	
# -- 17 private methods
# -- 18 signal listeners
# -- 19 innerclasses

