extends "res://characters/enemies/Enemy.gd"

signal spawn_laser(Laser, location)

onready var muzzle = $Muzzle
onready var laser_sound = $LaserSound

var Laser = preload("res://projectiles/EnemyLaser.tscn")

func shoot():
	emit_signal("spawn_laser", Laser, muzzle.global_position)
	laser_sound.play()

func _on_ShootTimer_timeout():
	shoot()
