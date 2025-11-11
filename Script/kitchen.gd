extends Node2D

# Ambil referensi ke BurgerStackManager yang ada di Plate
@onready var burger_stack_manager = $Plate/StackBurger

func _ready():
	# Hubungkan tombol-tombol bahan ke fungsi saat ditekan
	$IngredientButtons/BunButton.pressed.connect(func():
		burger_stack_manager.add_ingredient("res://Assets/bun.png")
	)
	
	$IngredientButtons/LettuceButton.pressed.connect(func():
		burger_stack_manager.add_ingredient("res://Assets/lettuce.png")
	)
