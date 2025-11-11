extends Node2D
@export var zombie_scene: PackedScene
@export var spawn_interval := 30

@onready var timer: Timer = $Timer
@onready var spawners = get_tree().get_nodes_in_group("monster_spawner")


const PATTY = preload("uid://kkbxen1mxjdw")


func _ready():
	if timer:
		timer.wait_time = spawn_interval
		timer.timeout.connect(spawn_zombie)
		timer.start()
	
	spawn_zombie()

func spawn_zombie():
	if not zombie_scene:
		push_error("Monster scene not assigned!")
		return
	
	# spawn zombie
	var zombie :Zombie= zombie_scene.instantiate()
	zombie.item_drops[PATTY] = 3
	var spawner = spawners[randi() % spawners.size()]
	var spawn_pos = spawner.position
	$"../Monsters".add_child(zombie)
	#get_tree().current_scene
	zombie.position = spawn_pos
	print(zombie.position)
