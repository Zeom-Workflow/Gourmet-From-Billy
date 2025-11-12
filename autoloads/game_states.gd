extends Node

var current_pos_index = 2
var is_changing_view = false

const view_positions = [
	Vector2(-2304.0, 0),
	Vector2(-1152.0, 0),
	Vector2(0.0, 0),
	Vector2(1152.0, 0),
]




#TODO: move this to signal bus
signal change_camera_view
