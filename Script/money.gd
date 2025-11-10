extends Control

@onready var label = $Label

var money: int = 30

func add_money(jumlah: int):
	money += jumlah
	label.text = str(money)

func _ready() -> void:
	label.text = "Money: 0"

func _process(_delta: float) -> void:
	pass
