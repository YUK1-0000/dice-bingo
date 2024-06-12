class_name Menus extends Control

@onready var result_menu = $ResultMenu as ResultMenu


func show_result_menu() -> void:
	result_menu.show_()
