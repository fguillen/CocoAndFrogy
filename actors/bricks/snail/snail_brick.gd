# -- 01 @tool
# -- 02 class_name
class_name SnailBrick
# -- 03 extends
extends Brick

# -- 04 # docstring
#
# -- 05 signals
signal hurt_with_shield()

# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var head_showing_interval := Vector2(2.0, 4.0)
@export var head_showing_duration := Vector2(1.0, 2.0)

# -- 09 public variables
# -- 10 private variables
var _is_head_out := false

# -- 11 onready variables
@onready var head_collision: CollisionShape2D = $CollisionShape2D
@onready var timer_show_head = $TimerShowHead
@onready var timer_hide_head = $TimerHideHead

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready():
	super()
	print("XXX: Snail._ready()")
	_hide_head()


# -- 15 remaining built-in virtual methods
# -- 16 public methods
func hurt_in_shield():
	hurt_with_shield.emit()
	
	if _is_head_out:
		animation_state_machine.travel("hurt_in_shield_with_head_out")
	else:
		animation_state_machine.travel("hurt_in_shield")
		
		
func _hide_head():
	print("XXX: _hide_head()")
	head_collision.disabled = true
	
	if _is_head_out:
		animation_state_machine.travel("hide_head")

	timer_show_head.start(randf_range(head_showing_interval.x, head_showing_interval.y))
	_is_head_out = false


func _show_head():
	print("XXX: _show_head()")
	head_collision.disabled = false
	animation_state_machine.travel("show_head")
	timer_hide_head.start(randf_range(head_showing_duration.x, head_showing_duration.y))
	_is_head_out = true
	
	
# -- 18 signal listeners
func _on_timer_show_head_timeout():
	_show_head()


func _on_timer_hide_head_timeout():
	_hide_head()
	
	
func _on_animation_tree_animation_started(anim_name):
	print("XXX: animation_tree: ", anim_name)
# -- 19 subclasses









func _on_animation_player_animation_started(anim_name):
	print("XXX: animation_player: ", anim_name)
