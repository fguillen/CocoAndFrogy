# -- 01 @tool
# -- 02 class_name
class_name MouseBrick

# -- 03 extends
extends Brick

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var walnuts_interval := Vector2(2.0, 5.0)
@export var walnut_template: PackedScene
@export var walnut_impulse := 500.0

# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
@onready var _timer = $Timer
@onready var tongue = %TongueSprite2D


#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	_timer.start(randf_range(walnuts_interval.x, walnuts_interval.y))	
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
# -- 17 private methods
func _shoot_walnut():
	print("XXX: _shoot_walnut()")
	var walnut: RigidBody2D = walnut_template.instantiate()
	get_tree().root.add_child(walnut)
	walnut.global_position = tongue.global_position
	walnut.apply_impulse(Vector2.DOWN.rotated(tongue.global_rotation) * walnut_impulse)
	
	_timer.start(randf_range(walnuts_interval.x, walnuts_interval.y))
	
	
# -- 18 signal listeners
func _on_timer_timeout():
	_shoot_walnut()
# -- 19 innerclasses




