extends Node2D
class_name Main

const PISTOL_BULLET = preload("uid://dn14mgqmrb0xk")
@onready var camera: Camera2D = $Camera

@onready var backyard: Node2D = $Backyard

const scenepositions = {
	"backyard" : Vector2(-1152, 0),
	"kitchen" : Vector2.ZERO,
	"shop" : Vector2(1152, 0),
}

func change_camera(scene: String):
	var scenepos = scenepositions.get(scene)
	if scenepos == null : return
	var tween = get_tree().create_tween()
	tween.tween_property(camera, "position", scenepos, 0.2)

func _ready() -> void:
	Inventory.money = 5
	for i in 5:
		Inventory.ammo.append(PISTOL_BULLET)
	for i in 3:
		var ammo = Inventory.ammo.pop_back()
		Inventory.gun_mag.append(ammo)
	pass # Replace with function body.


func _on_backyard_pressed() -> void:
	change_camera("backyard")

func _on_shop_pressed() -> void:
	change_camera("shop")

func _on_kitchen_pressed() -> void:
	change_camera("kitchen")

func _on_kitchen_2_pressed() -> void:
	change_camera("kitchen")


func _on_cheat_pressed() -> void:
	for i in 9:
		Inventory.ammo.append(PISTOL_BULLET)
