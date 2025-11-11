extends Node2D

var stack_items: Array[Sprite2D] = []

const STACK_OFFSET_Y := -25.0
const SCALE_STEP := 0.0 # ubah ke 0.03 kalau mau efek 2.5D

@onready var stack_container = $StackContainer


func add_ingredient(texture_path: String):
	var ingredient = Sprite2D.new()
	ingredient.texture = load(texture_path)

	var base_y := 0.0
	var scale_factor := 1.0

	if stack_items.size() > 0:
		var last_item = stack_items[-1]
		base_y = last_item.position.y + STACK_OFFSET_Y
		scale_factor = last_item.scale.y - SCALE_STEP

	ingredient.position = Vector2(0, base_y)
	ingredient.scale = Vector2(scale_factor, scale_factor)

	# Inilah bagian penting:
	ingredient.z_index = stack_items.size()
	ingredient.modulate = Color(1, 1, 1, 0.8 - (stack_items.size() * 0.1))

	stack_container.add_child(ingredient)
	stack_items.append(ingredient)

	print("Added ingredient:", texture_path, " total:", stack_items.size())


func reset_stack():
	for item in stack_items:
		item.queue_free()
	stack_items.clear()
