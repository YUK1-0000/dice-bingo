class_name UI extends Control

@onready var score_label = $MarginContainer/HBoxContainer/VBoxContainer/ScoreLabel as Label


func _ready() -> void:
	Events.game_start.connect(func(): show())
	Events.game_reset.connect(func(): hide())
	Events.score_updated.connect(update)


func update() -> void:
	score_label.text = str(Game.score)
