class_name Enemy
extends Node2D

const PATTY = preload("uid://kkbxen1mxjdw")


@export var MAX_HP : float = 2.
@onready var hp := MAX_HP

func take_damage(damage = 1):
	print("take damage")
	hp -= damage
	if hp <= 0:
		kill()

func kill():
	Inventory.ingredients.append(PATTY)
	print(Inventory.ingredients)
	queue_free()
