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
	"splash": "res://scenes/godot_wink_scene/godot_wink_scene.tscn",
	"logo": "res://scenes/logo_scene/logo_scene.tscn",
	"menu": "res://scenes/menu_scene/menu_scene.tscn",
	"options": "res://scenes/options_scene/options_scene.tscn",
	"levels": "res://scenes/level_selection_scene/level_selection_scene.tscn",
	"credits": "res://scenes/credits_scene/credits_scene.tscn",
	"level_00": "res://scenes/levels/level_00.tscn",
	"level_01": "res://scenes/levels/level_01.tscn",
	"level_02": "res://scenes/levels/level_02.tscn",
	"level_03": "res://scenes/levels/level_03.tscn",
	"level_04": "res://scenes/levels/level_04.tscn",
	"level_05": "res://scenes/levels/level_05.tscn",
	"stats": "res://scenes/stats_scene/stats_scene.tscn",
	"game_over": "res://scenes/game_over_scene/game_over_scene.tscn",
	"end": "res://scenes/end_scene/end_scene.tscn",
	"backdoor": "res://scenes/backdoor_scene/backdoor_scene.tscn",
}

# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func go_to(scene_name: String):
	SceneSwitcher.switch_to(_scenes[scene_name])


func go_to_with_delay(scene_name: String, delay: float = 1.0):
	await get_tree().create_timer(delay).timeout
	go_to(scene_name)
	

func go_to_level(level_num: int):
	var level_name = "level_%02d" % level_num
	
	print("XXX level_name: ", level_name)
	
	if _scenes.has(level_name):
		go_to(level_name)
	else:
		go_to("end")


func quit():
	get_tree().quit()
	
	
# -- 17 private methods
# -- 18 signal listeners
# -- 19 innerclasses
