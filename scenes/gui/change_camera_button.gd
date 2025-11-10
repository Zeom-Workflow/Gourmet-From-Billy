@tool
extends Button

@export var label: String
@export var camera: Camera2D
@export var node_destination: Node2D

func _ready() -> void:
	$Label.text = label

func change_camera():
	var node_pos = node_destination.global_position 
	var tween = get_tree().create_tween()
	tween.tween_property(camera, "global_position", node_pos, 0.2)


func _on_pressed() -> void:
	if not camera: print('error camera is not set')
	if not node_destination: print('error node_destination is not set')

	change_camera()
