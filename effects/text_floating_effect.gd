# -- 01 @tool
# -- 02 class_name
# -- 03 extends
extends Node2D

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var life_time := 2.0
@export var max_angle := 45.0 
@export var max_distance := 200
@export var text := "Text test": set = _set_text


# -- 09 public variables
# -- 10 private variables
var _max_angle_rad: float


# -- 11 onready variables
@onready var label = %Label

	
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	visible = false
	_max_angle_rad = deg_to_rad(max_angle)


# -- 15 remaining built-in virtual methods
# -- 16 public methods
func perform(text: String):
	var instance = _replicate()
	instance.text = text
	instance.visible = true
	instance.animate()
	
	await get_tree().create_timer(life_time).timeout
	instance.queue_free()
	

func animate():
	var destination_transform = _destination_transform()
	
	global_rotation = destination_transform.rotation
	
	var tween = create_tween()
	tween.tween_property(self, "global_position", destination_transform.position, 1.0)
	
	
	
	
# -- 17 private methods	
func _replicate() -> Variant:
	var instance = self.duplicate()
	get_tree().get_current_scene().add_child(instance)
	instance.global_position = global_position
	print("XXX1: global_position: ", global_position)
	return instance
	
	
func _destination_transform() -> MiniTransform:
	var distance = randf_range(0.0, max_distance)
	var direction = Vector2.UP.rotated(randf_range(-_max_angle_rad, _max_angle_rad))
	var position = global_position + (direction * distance)
	var rotation = direction.angle() + deg_to_rad(90.0)
	
	return MiniTransform.new(position, rotation)


func _set_text(value: String):
	label.text = text
	
	
# -- 18 signal listeners
# -- 19 subclasses
class MiniTransform:
	var position: Vector2
	var rotation: float

	func _init(position, rotation):
		self.position = position
		self.rotation = rotation

