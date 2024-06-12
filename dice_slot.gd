class_name DiceSlot extends CenterContainer

@export var dice: Dice

@onready var sprite = $Panel/Sprite2D as Sprite2D
@onready var set_button = $SetButton as Button


func update() -> void:
	print("update")
	# diceのテクスチャの反映とボタンの切り替え
	if dice:
		sprite.texture = dice.texture
	else:
		sprite.texture = null
	
	# diceがないときにボタンを可視化
	set_button.visible = not dice


func set_dice(dice_: Dice) -> void:
	print("set dice")
	dice = dice_
	update()


func remove_dice() -> void:
	print("remove dice")
	dice = null
	update()


func _on_set_button_pressed() -> void:
	Events.slot_pressed.emit(self)
	#set_dice(Game.current_dice)
