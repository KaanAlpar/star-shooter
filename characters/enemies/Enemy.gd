extends Area2D

signal enemy_died(score, location)

export (int) var _speed = 100
export (int) var _health = 1
export (int) var _damage = 0
export (int) var _score = 10

onready var hit_sound = $HitSound

func _physics_process(delta):
	global_position += Vector2.DOWN * _speed * delta

func _on_Enemy_area_entered(area):
	if area is Player:
		area.take_damage(_damage)

func take_damage(damage):
	hit_sound.play()
	_health -= damage
	if _health <= 0:
		queue_free()
		emit_signal("enemy_died", _score, global_position)
