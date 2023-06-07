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
@export var speed := 200.0
# -- 09 public variables
# -- 10 private variables
# -- 11 onready variables
@onready var animatable_body_2d = $AnimatableBody2D
@onready var character_body_2d_3 = $CharacterBody2D3
@onready var character_body_2d_4 = $CharacterBody2D4
@onready var animatable_body_2d_6 = $AnimatableBody2D6
@onready var animatable_body_2d_4 = $AnimatableBody2D4
@onready var character_body_2d_6 = $CharacterBody2D6
@onready var animatable_body_2d_3 = $AnimatableBody2D3
@onready var character_body_2d_7 = $CharacterBody2D7
@onready var static_body_2d_7 = $StaticBody2D7
@onready var character_body_2d_8 = $CharacterBody2D8
@onready var static_body_2d_8 = $StaticBody2D8

#
# -- 12 optional built-in virtual _init method
# -- 13 optional built-in virtual _enter_tree() method
# -- 14 built-in virtual _ready method
# -- 15 remaining built-in virtual methods
func _physics_process(delta):
	animatable_body_2d.global_position.x -= speed * delta
	character_body_2d_3.move_and_collide(Vector2.LEFT * speed * delta)
	character_body_2d_4.move_and_collide(Vector2.LEFT * speed * delta)
	animatable_body_2d_6.global_position.x -= speed * delta
	animatable_body_2d_4.global_position.x -= speed * delta
	
	character_body_2d_6.move_and_collide(Vector2.RIGHT * speed * delta)
	animatable_body_2d_3.global_position.x -= speed * delta
	
	character_body_2d_7.move_and_collide(Vector2.RIGHT * speed * delta)
	static_body_2d_7.global_position.x -= speed * delta
	
	static_body_2d_8.move_and_collide(Vector2.LEFT * speed * delta)


# -- 16 public methods
func reload():
	get_tree().reload_current_scene()
	
	
# -- 17 private methods
# -- 18 signal listeners
# -- 19 subclasses

