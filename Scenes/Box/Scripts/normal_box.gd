class_name NormalBox extends CharacterBody2D

@export_category("Variables")
@export var gravity : int = 100

var motion : Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	velocity.y = gravity
	move_and_slide()
	velocity = Vector2.ZERO

func _move_on_slide(vector : Vector2) -> void:
	velocity.x = vector.x
