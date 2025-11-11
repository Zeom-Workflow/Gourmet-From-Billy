extends Area2D

var current_order = [
	{ "nama": "burger", "price": 14 },
	{ "nama": "jus", "price": 13 }
]

@onready var inventory = get_node("/root/Inventory")
@onready var money_label: Label = $"/root/Main/GUI/MoneyCount"


func _ready():
	update_money_ui()


func verify_order(item_name: String) -> bool:
	for item in current_order:
		if item["nama"] == item_name:
			# Tambahkan uang ke Inventory, bukan ke label
			inventory.money += item["price"]

			# Update tampilan label
			update_money_ui()
			return true

	return false


func update_money_ui():
	if money_label:
		money_label.text = str(inventory.money)
