extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	$BulletCount.text = "x{0}".format([Inventory.ammo.size()])
	$MoneyCount.text = "x{0}".format([Inventory.money])
	pass
