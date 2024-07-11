class_name Normalplate extends Area2D

@export_category("Configure")
@export var door_to_open : Node2D = null 
@export var laser_to_disable : Node2D = null

func _on_body_entered(body: Node2D) -> void:
	if body is NormalBox:
		$Particles.set_deferred("emitting", false)
		if door_to_open != null:
			door_to_open.open.emit()
		if laser_to_disable != null:
			laser_to_disable.disable.emit()

func _on_body_exited(body: Node2D) -> void:
	$Particles.set_deferred("emitting", true)
	if body is NormalBox:
		if door_to_open != null:
			door_to_open.close.emit()
		if laser_to_disable != null:
			laser_to_disable.enable.emit()
