extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var children = get_children()
	for child in children:
		child.modulate = Color(0.013, 0.013, 0.013)
	
	for i in Inventory.gun_mag.size():
		children.get(i).modulate = Color(1.0, 1.0, 1.0)
