class_name MainMenu extends Control


func _ready() -> void:
	Events.game_reset.connect(show)


func _on_start_button_pressed() -> void:
	hide()
	Events.game_start.emit()
