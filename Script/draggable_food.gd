@tool
extends Area2D

@export var food: Food

var dragging := false
var drag_offset := Vector2.ZERO
var start_position := Vector2.ZERO
var is_over_npc := false

@onready var collision_shape: CollisionShape2D = $CollisionShape

func _ready():
	start_position = global_position
	connect("area_entered", _on_area_entered)
	connect("area_exited", _on_area_exited)

func _on_area_entered(area):
	if area.name == "NPC":
		is_over_npc = true

func _on_area_exited(area):
	if area.name == "NPC":
		is_over_npc = false




func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				if collision_shape:
					
					var mouse_local = collision_shape.to_local(get_global_mouse_position())
					if collision_shape.shape.get_rect().has_point(mouse_local):
						dragging = true
						drag_offset = global_position - get_global_mouse_position()

			else:
				if dragging:
					dragging = false

					if dragging == false and is_over_npc:
						var npc = get_node("../NPC")
						if not npc is NPC: return
						if npc.verify_order(food): 
							queue_free()
						else:
							global_position = start_position
					else:
							global_position = start_position



	if event is InputEventMouseMotion and dragging:
		global_position = get_global_mouse_position() + drag_offset
