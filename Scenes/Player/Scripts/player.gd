class_name Player extends CharacterBody2D

@export_category("Variables")
@export var max_speed : int = 80
@export var jump : int = -120
@export var gravity : int = 10
@export var max_health : int = 80
@onready var health : int = max_health

var started_labtop : bool = false
var labtop = preload("res://Scenes/Player/labtop.tscn")
var labtop_instance = null

var can_rotate_jump : bool = false

signal bounce(force : float)
signal damage(amount : int)
signal died

func _ready() -> void:
	bounce.connect(_on_bounce)
	
func _physics_process(delta: float) -> void:
	_movement()
	_vertical()
	_push_box()
	_bounce()
	_start_labtop()
	
	move_and_slide()

func _push_box(delta : float = get_physics_process_delta_time()) -> void:
	for index in get_slide_collision_count():
		var collision = get_slide_collision(index)
		if collision.get_collider() is NormalBox:
			collision.get_collider()._move_on_slide(-collision.get_normal() * max_speed / 3)

func _movement(delta : float = get_physics_process_delta_time()) -> void:
	if Input.is_action_pressed("ui_right") && !Input.is_action_pressed("ui_left"):
		velocity.x = max_speed
		$Character/Sprite2D.flip_h = false
	elif Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right"):
		velocity.x = -max_speed
		$Character/Sprite2D.flip_h = true
	else:
		velocity.x = lerpf(velocity.x, 0, 0.2)

func _vertical(delta : float = get_physics_process_delta_time()) -> void:
	if !is_on_floor():
		velocity.y += gravity
		
	if is_on_floor():
		velocity.y = gravity
		can_rotate_jump = true
		
	if Input.is_action_just_pressed("ui_up") && is_on_floor():
		velocity.y = jump
		
	if Input.is_action_just_pressed("ui_up") && can_rotate_jump && !is_on_floor():
		velocity.y = jump
		can_rotate_jump = false

func _bounce() -> void:
	if $Bounce.is_colliding():
		bounce.emit(jump * 1.5)

func _on_bounce(force: float) -> void:
	velocity.y = force
	can_rotate_jump = true

func _start_labtop() -> void:
	if Input.is_action_just_pressed("ui_accept"):
		
		$"../Labtop".active = true
		$"../Labtop".show()
		$"../Labtop".position = position
