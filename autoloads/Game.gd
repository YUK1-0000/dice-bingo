extends Node

@onready var main: Node = get_tree().root.get_node("Main")
@onready var board = main.get_node("Board") as Board
@onready var current_dice_slot = main.get_node("CurrentDiceSlot") as DiceSlot

var is_started := false
var current_dice: Dice = null
var dice: Array[Dice] = [
	preload("res://resources/dice/dice_1.tres"),
	preload("res://resources/dice/dice_2.tres"),
	preload("res://resources/dice/dice_3.tres"),
	preload("res://resources/dice/dice_4.tres"),
	preload("res://resources/dice/dice_5.tres"),
	preload("res://resources/dice/dice_6.tres")
]


func _process(_delta: float) -> void:
	if is_started and not current_dice:
		Events.turn_begin.emit()


func roll_dice() -> void:
	print("dice roll")
	current_dice = dice.pick_random()
	current_dice_slot.set_dice(current_dice)


func set_current_dice(slot: DiceSlot) -> void:
	print(board.get_neighbors_slot_of(slot).map(
		func(s: DiceSlot) -> Vector2:
			return s.coords
	))
	
	# クリックされたDiceSlotにcurrent_diceをセットして色を付けてターンエンド
	slot.set_dice(current_dice)
	remove_current_dice()
	Events.turn_end.emit()


func remove_current_dice() -> void:
	current_dice = null
	current_dice_slot.remove_dice()


func end_turn() -> void:
	check_bingo()
	check_game_is_over()


func check_bingo() -> void:
	if board.get_bingo_slots():
		Events.get_bingo.emit()


func check_game_is_over() -> void:
	if board.is_full():
		Events.game_over.emit()


func game_over() -> void:
	is_started = false
	print("game over")
	Score.update()


func game_reset() -> void:
	print("game reset")
	board.clear_dice()


func on_slot_pressed(slot: DiceSlot) -> void:
	if not slot.has_dice():
		set_current_dice(slot)
