# -- 01 @tool
@icon("res://actors/frogy/frogy.png")
# -- 02 class_name
class_name Frogy
# -- 03 extends
extends Character

# -- 04 # docstring
#
# -- 05 signals
signal boosted()

# -- 06 enums
# -- 07 constants
# -- 08 exported variables
# -- 09 public variables
# -- 10 private variables
var _attached_to: Node2D

# -- 11 onready variables
@onready var collision_shape_2d = $CollisionShape2D

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	Global.frogy_ready(self)
		
	
# -- 15 remaining built-in virtual methods
func _process(_delta):
	if not _attached_to:
		return
		
	global_position = _attached_to.global_position
	
	
# -- 16 public methods
func detach():
	if not _attached_to: 
		return
		
	_attached_to = null
	movement_manager.direction = Vector2.UP
	movement_manager.set_physics_process(true)
	
	
func boost(factor: float):
	movement_manager.speed *= factor
	boosted.emit()
	

func attached_to(node: Node2D):
	movement_manager.direction = Vector2.UP
	movement_manager.set_physics_process(false)
	_attached_to = node
	
	
	
	
# -- 17 private methods
# -- 18 signal listeners
# -- 19 subclasses
