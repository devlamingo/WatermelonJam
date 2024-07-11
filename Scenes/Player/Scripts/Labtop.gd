class_name Labtop extends Control

enum{STARTUP, STARTED}
var current_step = STARTUP

var active : bool = false
var started_up : bool = false

func _physics_process(delta: float) -> void:
	if active:
		get_tree().paused = true
		$Camera2D.make_current()
		match current_step:
			STARTUP:
				if !started_up:
					show()
					await get_tree().create_timer(1).timeout
					started_up = true
					%Loading.show()
					%Loading/Loadingplayer.play("Startup")
			STARTED:
				show()
			
func _on_loadingplayer_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Startup":
		%Loading.hide()
		await get_tree().create_timer(1).timeout
		%Prepering/Preperingplayer.play("Typing")
		%Prepering.show()

func _on_preperingplayer_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Typing":
		%Prepering.hide()
		await get_tree().create_timer(1.5).timeout
		%Apps.show()
		current_step = STARTED

func _on_line_edit_text_submitted(new_text: String) -> void:
	var command_parts = new_text.split(" ")
	var command = command_parts[0].strip_edges()
	var argument = ""
	if command_parts.size() > 1:
		argument = command_parts[1].strip_edges()

	$Terminal/VBoxContainer/LineEdit.clear()

	match command:
		"help":
			$Terminal/VBoxContainer/TextEdit.text = "Help Menu:-\ncam <cam_id>\nlaser <laser_id>\nlocked <door_id>"
		"cam", "laser", "locked":
			if argument.length() == 0:
				$Terminal/VBoxContainer/TextEdit.text = "write %s_id please !, %s <%s_id>" % [command, command, command]
			else:
				$Terminal/VBoxContainer/TextEdit.text = "Executing %s with id %s" % [command, argument]
		_:
			$Terminal/VBoxContainer/TextEdit.text = "command not found X_X !"

func _on_terminal_pressed() -> void:
	$Terminal.show()

func _on_terminal_close_requested() -> void:
	$Terminal.hide()

func _on_exit_button_pressed() -> void:
	hide()
	$"../Player/Playercamera".make_current()
