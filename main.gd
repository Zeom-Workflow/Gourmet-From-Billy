extends Node2D
class_name Main

const PISTOL_BULLET = preload("uid://dn14mgqmrb0xk")

func _ready() -> void:
	Inventory.money = 5
	for i in 5:
		Inventory.ammo.append(PISTOL_BULLET)
	for i in 3:
		var ammo = Inventory.ammo.pop_back()
		Inventory.gun_mag.append(ammo)
