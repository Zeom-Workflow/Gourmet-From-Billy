extends Enemy
class_name Zombie

@onready var hp_bar: ProgressBar = $HpBar
@onready var hurtbox: Area2D = $Hurtbox

var is_aimed := false

func _ready() -> void:
	
	#for autoload in get_tree().root.get_children():
		#if autoload != get_tree().get_current_scene():
			#print(autoload)
	hurtbox.mouse_entered.connect(func(): is_aimed = true)
	hurtbox.mouse_exited.connect(func(): is_aimed = false)
	hp_bar.value = 100

func _process(delta: float) -> void:
	hp_bar.value = (hp / MAX_HP)  * 100

func _physics_process(delta: float) -> void:
	pass
