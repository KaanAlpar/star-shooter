extends Area2D

export (int) var speed = 1000
export (int) var damage = 1

func _process(delta):
	global_position.y += speed * delta

func _on_EnemyLaser_area_entered(area):
	if area is Player:
		area.take_damage(damage)
		queue_free()
