extends Area2D
class_name BulletHitbox

var can_hit := true
@export var ammo_type : Ammo

func _on_timer_timeout() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	print("area entered: ",area.get_parent().name)
