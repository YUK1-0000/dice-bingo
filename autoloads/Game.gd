extends Node

@onready var main: Node = get_tree().root.get_node("Main")
@onready var current_dice_slot = main.get_node("CurrentDiceSlot") as DiceSlot
@onready var dice: Array[Dice] = [
	preload("res://resources/dice/dice_1.tres"),
	preload("res://resources/dice/dice_2.tres"),
	preload("res://resources/dice/dice_3.tres"),
	preload("res://resources/dice/dice_4.tres"),
	preload("res://resources/dice/dice_5.tres"),
	preload("res://resources/dice/dice_6.tres")
]

var current_dice: Dice


func _ready() -> void:
	Events.turn_begin.connect(dice_roll)
	Events.dice_setted.connect(remove_current_dice)


func _process(_delta: float) -> void:
	if not current_dice_slot.dice:
		Events.turn_begin.emit()


func dice_roll() -> void:
	print("dice roll")
	current_dice = dice.pick_random()
	current_dice_slot.set_dice(current_dice)


func remove_current_dice() -> void:
	current_dice = null
	current_dice_slot.remove_dice()
