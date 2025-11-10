extends Area2D

var current_order = [
	{ "nama": "burger", "price": 14 },
	{ "nama": "jus", "price": 13 }
]

@onready var kasir = get_node("../money")


# --- BUBBLE TEXT ---
func show_bubble(text):
	var bubble = preload("res://Scane/bubbleText.tscn").instantiate()
	

	# gunakan canvas_transform Godot 4
	var screen_pos = get_viewport().canvas_transform * global_position

	bubble.position = screen_pos + Vector2(0, -100)

	bubble.show_text(text)



# --- NPC meminta pesanan ---
func request_order():
	if current_order.size() == 0:
		return
	
	var order_item = current_order[0]["nama"]
	show_bubble("Saya pesan " + order_item.capitalize())


# --- Verifikasi pesanan dari player ---
func verify_order(item_name: String) -> bool:
	for item in current_order:
		if item_name == item["nama"]:
			kasir.add_money(item["price"])
			show_bubble("+" + str(item["price"]))
			return true
	
	# Item tidak cocok
	show_bubble("Salah!")
	return false
