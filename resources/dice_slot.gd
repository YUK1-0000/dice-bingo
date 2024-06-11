class_name DiceSlot extends Resource

signal ui_update

@export var dice: Dice


func set_dice(pips: int = randi_range(1, 6)) -> void:
	
	# diceがなければpipsの目のDiceを代入
	if dice:
		return
	dice = load("res://resources/dice/dice_" + str(pips) + ".tres")
	ui_update.emit()


func remove_dice() -> void:
	dice = null
	ui_update.emit()
