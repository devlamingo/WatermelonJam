class_name ElectricDoor extends StaticBody2D

var default_position : Vector2

signal open
signal close

func _ready() -> void:
	open.connect(_open_animation)
	close.connect(_close_animation)
	default_position = global_position

func _open_animation() -> void:
	if is_inside_tree():
		var opening_tween = get_tree().create_tween()
		opening_tween.tween_property(self, "global_position", global_position - Vector2(0, 50), 1.5)
		opening_tween.set_trans(Tween.TRANS_SINE)

func _close_animation() -> void:
	if is_inside_tree():
		var close_tween = get_tree().create_tween()
		close_tween.tween_property(self, "global_position", default_position, 1.5)
		close_tween.set_trans(Tween.TRANS_SINE)

