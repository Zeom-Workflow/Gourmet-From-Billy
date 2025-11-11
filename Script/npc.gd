extends Area2D
class_name NPC
const BUBBLE_TEXT = preload("uid://sdonqfroy67")


var current_order = [
	{ "item": Globals.COOKED_PATTY},
]


# --- BUBBLE TEXT ---
func show_bubble(text):

	# gunakan canvas_transform Godot 4
	var bubble = BUBBLE_TEXT.instantiate()
	var screen_pos = get_viewport().canvas_transform * global_position

	bubble.position = screen_pos + Vector2(0, -100)

	#bubble.show_text(text)	



# --- NPC meminta pesanan ---
func request_order():
	if current_order.size() == 0:
		return
	
	var order_item = current_order[0]["nama"]
	show_bubble("Saya pesan " + order_item.capitalize())


# --- Verifikasi pesanan dari player ---
func verify_order(item: Food) -> bool:
	print(item)
	for order_item in current_order:
		if order_item['item'] == item:
			show_bubble("+" + str(item.price))
			Inventory.money += item.price
			return true
	
	# Item tidak cocok
	show_bubble("Salah!")
	return false
