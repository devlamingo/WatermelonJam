class_name LiveCamera extends Area2D

var active : bool = true

func _on_body_entered(body: Node2D) -> void:
	if body is Player && active:
		print("Command")
