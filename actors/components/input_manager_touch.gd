# -- 01 @tool
# -- 02 class_name
class_name InputManagerTouch
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var bumping_sensitivity := 1000.0
@export var dashing_sensitivity := 6000.0
@export var moving_sensitivity := 100.0

# -- 09 public variables
# -- 10 private variables
var _character: Node2D

# -- 11 onready variables
#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	_character = owner
	
	
# -- 15 remaining built-in virtual methods
func _input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		_touch_position_changed(event.position)
			
	if event is InputEventScreenDrag:
		_check_if_bumping(event.velocity)
		_check_if_dashing(event.velocity)


# -- 16 public methods
		
	
# -- 17 private methods
func _touch_position_changed(touch_position: Vector2):
	var direction = touch_position - _character.position
	_emit_input_action_directions(direction)


func _check_if_bumping(velocity: Vector2):
	if velocity.y < -bumping_sensitivity:
		_emit_input_action_bump()
		
		
func _check_if_dashing(velocity: Vector2):
	if abs(velocity.x) > dashing_sensitivity:
		_emit_input_action_dash()
		
	
func _emit_input_action_directions(direction: Vector2):
	Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")	
	
	# ui_left
	var event_ui_left = InputEventAction.new()
	event_ui_left.action = "ui_left"
	event_ui_left.pressed = direction.x < 0 and abs(direction.x) > moving_sensitivity
	Input.parse_input_event(event_ui_left)
	
	# ui_right
	var event_ui_right = InputEventAction.new()
	event_ui_right.action = "ui_right"
	event_ui_right.pressed = direction.x > 0 and abs(direction.x) > moving_sensitivity
	Input.parse_input_event(event_ui_right)
	
	# ui_up
	var event_ui_up = InputEventAction.new()
	event_ui_up.action = "ui_up"
	event_ui_up.pressed = direction.y < 0 and abs(direction.y) > moving_sensitivity
	Input.parse_input_event(event_ui_up)
	
	# ui_down
	var event_ui_down = InputEventAction.new()
	event_ui_down.action = "ui_down"
	event_ui_down.pressed = direction.y > 0 and abs(direction.y) > moving_sensitivity
	Input.parse_input_event(event_ui_down)
	
	

func _emit_input_action_bump():
	var event = InputEventAction.new()
	event.action = "bump"
	
	# Press
	event.pressed = true
	Input.parse_input_event(event)
	
	# Relase in next frame
	await get_tree().process_frame
	event.pressed = false
	Input.parse_input_event(event)
	
	
func _emit_input_action_dash():
	var event = InputEventAction.new()
	event.action = "dash"
	
	# Press
	event.pressed = true
	Input.parse_input_event(event)
	
	# Relase in next frame
	await get_tree().process_frame
	event.pressed = false
	Input.parse_input_event(event)
	
	
# -- 18 signal listeners
# -- 19 subclasses

