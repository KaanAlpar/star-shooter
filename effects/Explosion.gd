extends Particles2D

onready var sfx = $Sfx

func start():
	emitting = true
	sfx.play()
