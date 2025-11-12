@tool
extends Button

@export var label: String
@export var camera: Camera2D
@export var node_destination: Node2D

func _process(delta: float) -> void:
	$Label.text = label
