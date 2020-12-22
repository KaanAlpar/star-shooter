extends Node2D

signal spawn_enemy(EnemyType, location)

export (Array, PackedScene) var EnemyArray

onready var spawn_timer = $SpawnTimer

var spawn_positions = null

func _ready():
	randomize()
	spawn_positions = $SpawnPositions.get_children()

func _on_SpawnTimer_timeout():
	spawn_random_enemy()

func spawn_random_enemy():
	var index = randi() % spawn_positions.size()
	emit_signal("spawn_enemy", get_random_enemy(), spawn_positions[index].global_position)

func get_random_enemy():
	return EnemyArray[randi()%EnemyArray.size()]
	

func start():
	spawn_timer.start()

func stop():
	spawn_timer.stop()
