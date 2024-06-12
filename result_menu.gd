class_name ResultMenu extends Control

@onready var score_label = $Panel/CenterContainer/ScoreLabel as Label


func show_() -> void:
	show()
	update()


func update() -> void:
	print("result menu update")
	score_label.text = str(Game.score)
