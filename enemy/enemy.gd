class_name Enemy
extends Node2D



@export var MAX_HP : float = 2.
@export var item_drops : Dictionary[Ingredient, int]

@onready var hp := MAX_HP


func take_damage(damage = 1):
	print("take damage")
	hp -= damage
	if hp <= 0:
		kill()

func kill():
	print("get item drop",item_drops)
	
	for item_drop in item_drops:
		print("get item drop",item_drop)
		#Inventory.ingredients[item_drop] += 2
	print(Inventory.ingredients)
	queue_free()
