extends Area2D
class_name Player

signal player_died(location)
signal player_took_damage(hp_left)
signal spawn_laser(Laser, location)

onready var muzzle = $Muzzle
onready var hit_sound = $HitSound
onready var laser_sound = $LaserSound

var Laser = preload("res://projectiles/PlayerLaser.tscn")

var _velocity : Vector2
var _input_vector: Vector2

export (int) var _speed = 250
export (int) var _health = 999
export (int) var _damage = 3

func apply_movement(delta):
	_input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	_input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	global_position += _input_vector * _speed * delta
	global_position.x = clamp(global_position.x, 0, 540)
	global_position.y = clamp(global_position.y, 0, 960)
	

func _physics_process(delta):
	apply_movement(delta)
	if Input.is_action_just_pressed("shoot"):
		emit_signal("spawn_laser", Laser, muzzle.global_position)
		laser_sound.play()

func take_damage(damage):
	hit_sound.play()
	_health -= damage
	emit_signal("player_took_damage", clamp(_health, 0, _health))
	if _health <= 0:
		emit_signal("player_died", global_position)
		queue_free()

func _on_Player_area_entered(area):
	if area.is_in_group("enemies"):
		area.take_damage(_damage)
