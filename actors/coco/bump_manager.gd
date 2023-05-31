# -- 01 @tool
# -- 02 class_name
class_name BumpManager
# -- 03 extends
extends Node

# -- 04 # docstring
#
# -- 05 signals
signal bump_message(text: String)
signal bumped_achieved()
signal bumped()


# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var cooldown_time := 0.3
@export var bump_distant_perfect := 80
@export var bump_distant_max := 120
@export var boost_factor_perfect := 1.5
@export var boost_factor_no_perfect := 1.2


# -- 09 public variables
# -- 10 private variables
var _bump_frogy_position := Vector2.ZERO
var _bump_collision_position := Vector2.ZERO
var _cooling_down := false

# -- 11 onready variables
@onready var _timer = $Timer


#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func bump():
	# cooling down section
	if _cooling_down:
		return
		
	_cooling_down = true
	_timer.start(cooldown_time)
	
	# Calculate if frogy is in area
	var frogy = GroupsUtils.frogy
	if not frogy: 
		push_warning("Froggy not found")
		return
		
	if frogy._attached_to:
		bumped.emit()
		bumped_achieved.emit()
		frogy.detach()
		return
		
	var space_state = frogy.get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(frogy.global_position, frogy.global_position + (Vector2.DOWN * bump_distant_max * 2))
	var result = space_state.intersect_ray(query)
	
	if result.has("collider") and result.collider.is_in_group("coco"):
		var distance = frogy.global_position.distance_to(result.position)
		_bump_frogy_position = frogy.global_position
		_bump_collision_position = result.position
		
		if distance <= bump_distant_perfect:
			bump_message.emit("Perfect")
			frogy.boost(boost_factor_perfect)
			bumped_achieved.emit()
			GlobalEvents.emit_bump_perfect_performed()
			
		elif distance <= bump_distant_max:
			if frogy.movement_manager.direction.dot(Vector2.DOWN) > 0.0:
				bump_message.emit("Bit Early")
				GlobalEvents.emit_bump_early_performed()
			else: 
				bump_message.emit("Bit Late")
				GlobalEvents.emit_bump_late_performed()
			
			frogy.boost(boost_factor_no_perfect)
			bumped_achieved.emit()
		else: 
			bump_message.emit("Too Far")
	else: 
		bump_message.emit("No way")
		
	bumped.emit()
	
	
# -- 17 private methods
# -- 18 signal listeners
func on_bump_input_received():
	bump()
	
func _on_timer_timeout():
	_cooling_down = false
	

# -- 19 subclasses




