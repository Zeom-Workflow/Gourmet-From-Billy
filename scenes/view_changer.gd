extends Control

@export var camera: Camera2D

@onready var change_view_button_left: Button = $ChangeViewButtonLeft
@onready var change_view_button_right: Button = $ChangeViewButtonRight

@onready var shop: Node2D = $"../../Shop"
@onready var kitchen: Node2D = $"../../Kitchen"
@onready var backyard: Node2D = $"../../Backyard"
@onready var cashier: Node2D = $"../../Cashier"

var view_order := ["shop", "backyard", "cashier", "kitchen"]

var current_view : String = "cashier"


func _ready() -> void:
	render_btn_labels()

@onready var views = {
	"shop": shop,
	"backyard": backyard,
	"cashier": cashier,
	"kitchen": kitchen,
}

func change_view(node_pos: Vector2):
	var tween = get_tree().create_tween()
	tween.tween_property(camera, "global_position", node_pos, 0.2)
	tween.tween_callback(render_btn_labels)

func render_btn_labels():
	var current_view_id = view_order.find(current_view)
	var prev_label = view_order.get(current_view_id - 1)
	var next_label = view_order.get(current_view_id + 1)
	print(prev_label)
	change_view_button_left.label = prev_label.capitalize() if prev_label else ""
	change_view_button_right.label = next_label.capitalize() if next_label else ""
	change_view_button_left.visible = true if prev_label else false
	change_view_button_right.visible = true if next_label else false


func _on_change_view_button_left_pressed() -> void:
	shift_view(-1)

func _on_change_view_button_right_pressed() -> void:
	shift_view(1)

func shift_view(direction: int):
	var current_idx = view_order.find(current_view)
	
	var new_idx = current_idx + direction
	
	if new_idx > 3 or new_idx < 0: return

	current_view = view_order[new_idx]
	var target_node = views[current_view]

	change_view(target_node.global_position)
