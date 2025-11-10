extends Area2D
@onready var shoot_cooldown: Timer = $ShootCooldown
var can_shoot := true

func _on_mouse_entered() -> void:
	PlayerVars.is_in_shooting_area = true


func _on_mouse_exited() -> void:
	PlayerVars.is_in_shooting_area = false

# TODO: move these to shooting mechanic script
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot") and PlayerVars.is_in_shooting_area:
		if can_shoot:
			can_shoot = false
			shoot_cooldown.start()
			shoot()

func reload():
	var max_gun_mag_size = 7
	for i in max_gun_mag_size:
		var bullet = Inventory.ammo.pop_back()
		if bullet:
			Inventory.gun_mag.append(bullet)
		else:
			print("no ammo left warning")


func empty_shoot():
	print("empty_shoot: reloading")
	reload()

func shoot():
	if not PlayerVars.can_shoot: return
	if Inventory.gun_mag.size() <= 0: 
		empty_shoot()
		return

	var bullet_hitbox_scene :Area2D = preload("uid://c6oiacxxl6duf").instantiate()
	bullet_hitbox_scene.position = get_local_mouse_position()
	self.add_child(bullet_hitbox_scene)

	Inventory.gun_mag.pop_back()  # consume ammo

	var space = get_world_2d().direct_space_state
	var mouse_pos = get_global_mouse_position()

	var query = PhysicsPointQueryParameters2D.new()
	query.position = mouse_pos
	query.collide_with_areas = true
	query.collide_with_bodies = false # ignore bodies

	var results = space.intersect_point(query)

	print("Hit results: ", results)

	if results.is_empty():
		print("MISS")
		return

	var enemies := []
	for r in results:
		var parent = r.collider.get_parent()
		if parent is Enemy:
			enemies.append(parent)

	if enemies.is_empty():
		print("No enemies under cursor")
		return

	# sort front-most enemy
	enemies.sort_custom(func(a, b):
		return a.position.y > b.position.y  # front by Y
	)

	enemies[0].take_damage(1)
	print("HIT:", enemies[0].name)

func _on_timer_timeout() -> void:
	can_shoot = true
