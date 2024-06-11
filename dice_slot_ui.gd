class_name DiceSlotUI extends CenterContainer

@export var slot: DiceSlot

@onready var sprite: Sprite2D = $Panel/Sprite2D
@onready var set_button: Button = $SetButton
@onready var remove_button: Button = $RemoveButton


func _ready() -> void:
	slot.ui_update.connect(update)


func update() -> void:
	
	# diceのテクスチャの反映とボタンの切り替え
	if slot.dice:
		sprite.texture = slot.dice.texture
		set_button.visible = false
		remove_button.visible = true
	else:
		sprite.texture = null
		set_button.visible = true
		remove_button.visible = false


func _on_set_button_pressed() -> void:
	slot.set_dice()


func _on_remove_button_pressed() -> void:
	slot.remove_dice()
