extends Node2D

var Player = preload("res://characters/player/Player.tscn")
var GameOverMenu = preload("res://ui/GameOverMenu.tscn")

onready var _player_spawn = $PlayerSpawn
onready var _enemy_spawner = $EnemySpawner
onready var ui_layer = $UILayer
onready var _hud = $UILayer/HUD
onready var _explosion = $Effects/Explosion
onready var _enemy_container = $EnemyContainer

var _player = null
var _score = 0

func _ready():
	new_game()

func new_game():
	update_score_and_hud(0)
	
	_player = Player.instance()
	add_child(_player)
	_player.global_position = _player_spawn.global_position
	_player.connect("player_died", self, "_on_player_died")
	_player.connect("spawn_laser", self, "spawn_laser")
	_player.connect("player_took_damage", self, "_on_player_took_damage")
	_hud.update_lives(_player._health)
	
	_enemy_spawner.start()

func _on_player_took_damage(hp):
	_hud.update_lives(hp)

func _on_player_died(location):
	create_explosion(location)
	game_over()

func spawn_laser(Laser, location):
	var laser = Laser.instance()
	laser.global_position = location
	add_child(laser)

func _on_EnemySpawner_spawn_enemy(EnemyType, location):
	var e = EnemyType.instance()
	e.global_position = location
	_enemy_container.add_child(e)
	e.connect("enemy_died", self, "_on_enemy_died")
	if e.has_signal("spawn_laser"):
		e.connect("spawn_laser", self, "spawn_laser")

func _on_DeathZone_area_entered(area):
	area.queue_free()

func _on_enemy_died(score, location):
	update_score_and_hud(_score + score)
	create_explosion(location)

func game_over():
	_enemy_spawner.stop()
	yield(get_tree().create_timer(3), "timeout")
	var game_over_menu = GameOverMenu.instance()
	ui_layer.add_child(game_over_menu)

func update_score_and_hud(val):
	_score = val
	_hud.update_score(_score)

func create_explosion(location):
	_explosion.global_position = location
	_explosion.start()
