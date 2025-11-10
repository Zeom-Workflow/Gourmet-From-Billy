@tool
extends Panel

@onready var texture_rect: TextureRect = $TextureRect

@export var item : ShopItem

func _process(_delta: float) -> void:
	if(item):
		$TextureRect.texture = item.texture
		$Price.text = "${0}".format([item.price])
	else:
		$TextureRect.texture = null
		$Price.text = "${0}".format([item.price])



func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if item is Ammo:
				Inventory.ammo.append(item)
				Inventory.money -= item.price


func _on_mouse_entered() -> void:
	texture_rect.modulate = Color(1.353, 1.353, 1.353, 1.0)


func _on_mouse_exited() -> void:
	texture_rect.modulate = Color(1.0, 1.0, 1.0, 1.0)
