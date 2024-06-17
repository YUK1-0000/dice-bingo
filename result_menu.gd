class_name ResultMenu extends Control

@onready var score_label = $Panel/CenterContainer/VBoxContainer/ScoreLabel as Label


func  _ready() -> void:
	Events.game_over.connect(
		func() -> void:
			show()
			update()
	)


func update() -> void:
	print("result menu update")
	score_label.text = str(Score.score)


func _on_continue_button_pressed() -> void:
	hide()
	Events.game_reset.emit()
