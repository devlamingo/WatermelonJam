extends Node2D

@export var viewport : Viewport
@export var external_camera : Camera2D
@export var viewport_camera : Camera2D

#func _ready():
	#$SubViewportContainer/SubViewport.world_2d = get_world_2d()
	#$SubViewportContainer/SubViewport.size = get_viewport().size
	#$SubViewportContainer/SubViewport/Camera2D.position = $Player.position

func _process(delta):
	pass
