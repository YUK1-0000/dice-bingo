class_name DiceSlot extends CenterContainer


@onready var sprite = $Panel/Sprite2D as Sprite2D

var dice: Dice = null
var coords: Vector2 = Vector2.ZERO


func update() -> void:
	print("update")
	# diceのテクスチャの反映とボタンの切り替え
	if has_dice():
		sprite.texture = dice.texture
	else:
		sprite.texture = null


func set_dice(dice_: Dice) -> void:
	print("set dice")
	dice = dice_
	update()


func set_color(color: Color) -> void:
	print("set color")
	sprite.modulate = color


func remove_dice() -> void:
	print("remove dice")
	dice = null
	update()


func _on_button_pressed() -> void:
	Events.slot_pressed.emit(self)


func has_dice() -> bool:
	return dice != null
