# -- 01 @tool
# -- 02 class_name
class_name Brick
# -- 03 extends
extends AnimatableBody2D

# -- 04 # docstring
#
# -- 05 signals
signal appeared()
signal hurt()
signal dying()
signal died()

# -- 06 enums
# -- 07 constants
# -- 08 exported variables
@export var health := 2
@export var score := 5
@export var auto_start := true

# -- 09 public variables

# -- 10 private variables
# -- 11 onready variables
@onready var animation_player = $AnimationPlayer
@onready var animation_state_machine: AnimationNodeStateMachinePlayback = $AnimationTree.get("parameters/playback")
@onready var animation_tree: AnimationTree = $AnimationTree

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
func _ready(): 
	_setup.call_deferred()
	
	GlobalEvents.emit_brick_ready(self)
	
	
# -- 15 remaining built-in virtual methods
# -- 16 public methods
func start():
	animation_tree.active = true
	
	
func impact():
	health -= 1
	hurt.emit()
	
	if health <= 0:
		_die()
	else:
		animation_state_machine.travel("hurt")
	
		
# -- 17 private methods
func _setup():
	if auto_start:
		start()
	
	
	
func _die():
	set_process(false)
	dying.emit()
	animation_state_machine.travel("die")

	
	
# -- 18 signal listeners
func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "appear":
		appeared.emit()
		
	elif anim_name == "die":
		died.emit()
		GlobalEvents.emit_brick_queued(self)
		queue_free()
		
		
# -- 19 subclasses
