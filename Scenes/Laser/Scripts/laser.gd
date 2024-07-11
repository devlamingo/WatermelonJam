class_name Laser extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("maybe will die")
