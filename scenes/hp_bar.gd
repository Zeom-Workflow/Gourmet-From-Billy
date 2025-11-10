extends ProgressBar


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.max_value = PlayerVars.MAX_HP
	self.value = PlayerVars.hp
