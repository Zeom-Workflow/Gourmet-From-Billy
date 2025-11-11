extends Area2D

@export var reload_bar: ProgressBar

@onready var shoot_cooldown: Timer = $ShootCooldown
@onready var reload_timer: Timer = $ReloadTimer

const AIM_CURSOR = preload("uid://bkuiea32hlhcn")

const max_gun_mag_size = 7
@onready var hand_gun: Node2D = $"../HandGunContainer/HandGun"

var can_shoot := true


func _process(delta: float) -> void:
	reload_bar.value = (reload_timer.time_left / reload_timer.wait_time) * 100
	render_cursor()
	render_hand_gun_sprite()

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


func shoot():
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



var return_tween : Tween

func render_cursor():
	if PlayerVars.is_in_shooting_area:
		var size = AIM_CURSOR.get_size()
		Input.set_custom_mouse_cursor(AIM_CURSOR, Input.CURSOR_ARROW, size / 2)
	else:
		Input.set_custom_mouse_cursor(null)

func render_hand_gun_sprite():
	if PlayerVars.is_in_shooting_area and not PlayerVars.is_reloading:
		var target = get_local_mouse_position() / 2
		hand_gun.position = hand_gun.position.lerp(target, 0.2)
		if return_tween:
			return_tween.kill()
			return_tween = null
	else:
		if return_tween == null:
			return_tween = create_tween()
			return_tween.set_ease(Tween.EASE_IN_OUT)
			return_tween.tween_property(hand_gun, "position", Vector2(0, 400), 0.2)
			return_tween.finished.connect(func(): return_tween = null)



func _on_shoot_cooldown_timeout() -> void:
	can_shoot = true

func _on_reload_timer_timeout() -> void:
	PlayerVars.is_reloading = false
	load_bullet_from_ammo_box()
	if Inventory.ammo.size() > 0:
		reload()

func load_bullet_from_ammo_box():
	var bullet = Inventory.ammo.pop_back()
	if bullet:
		Inventory.gun_mag.append(bullet)
	else:
		print("no ammo left warning")

func reload():
	if Inventory.gun_mag.size() >= max_gun_mag_size: return
	if Inventory.ammo.size() > 0:
		for i in max_gun_mag_size:
			PlayerVars.is_reloading = true
			reload_timer.start()


func empty_shoot():
	if not PlayerVars.is_reloading:
		reload()
