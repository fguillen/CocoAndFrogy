# -- 01 @tool
# -- 02 class_name
class_name BumpManager
# -- 03 extends
extends Node2D

# -- 04 # docstring
#
# -- 05 signals
# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var bump_distant_perfect := 80
@export var bump_distant_max := 120
@export var boost_factor_perfect := 1.5
@export var boost_factor_no_perfect := 1.0


# -- 09 public variables
# -- 10 private variables
var _bump_frogy_position := Vector2.ZERO
var _bump_collision_position := Vector2.ZERO

# -- 11 onready variables
@onready var animation_player = %AnimationPlayer

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
func _process(_delta):
	queue_redraw()
	
	
func _draw():
	draw_circle(to_local(_bump_frogy_position), 10.0, Color.CORAL)
	draw_circle(to_local(_bump_collision_position), 10.0, Color.GREEN_YELLOW)
	
	
# -- 16 public methods
func bump():
	animation_player.play("bump")
	
	# Calculate if frogy is in area
	var frogy = GroupsUtils.frogy
	var space_state = frogy.get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(frogy.global_position, frogy.global_position + (Vector2.DOWN * bump_distant_max * 2))
	var result = space_state.intersect_ray(query)
	
	if result.has("collider") and result.collider.is_in_group("coco"):
		var distance = frogy.global_position.distance_to(result.position)
		_bump_frogy_position = frogy.global_position
		_bump_collision_position = result.position
		
		if distance <= bump_distant_perfect:
			print("Bump boost_factor_perfect")
			GroupsUtils.frogy.boost(boost_factor_perfect)
		elif distance <= bump_distant_max:
			print("Bump boost_factor_no_perfect")
			if GroupsUtils.frogy.movement_manager.direction.dot(Vector2.DOWN) > 0.0:
				print("Bump too_early")
			else: 
				print("Bump too_late")
			
			GroupsUtils.frogy.boost(boost_factor_no_perfect)
		else: 
			print("Bump too_far")
		
		
	
	
# -- 17 private methods
# -- 18 signal listeners
func on_bump_input_received():
	bump()
	

# -- 19 subclasses

