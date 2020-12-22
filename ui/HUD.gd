extends Control

onready var lives_texture = $Lives
onready var score_label = $ScoreLabel

func update_score(val):
	score_label.text = "SCORE: " + str(val)

func update_lives(val):
	lives_texture.rect_size.x = val * 37
