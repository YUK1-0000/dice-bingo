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
var score: int = 0
enum HANDS {
	HIFUMI = -5,
	MENASHI = -2,
	DEME = 1,
	SHIGORO = 2,
	ARASHI = 3,
	PINZORO = 5,
}

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
	
	# クリックされたDiceSlotにcurrent_diceをセットしてターンエンド
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
	var slot_arrays := board.get_bingo_slots()
	if not slot_arrays:
		return
	
	# 列ごとに役を取得して得点
	for slot_array: Array[DiceSlot] in slot_arrays:
		var hand := get_hand(slot_array)
		print("hand: ", str(hand))
		score += hand
		Events.score_updated.emit()
		
		if hand == HANDS.MENASHI:
			slot_arrays.erase(slot_array)
	
	# 役が成立している列のダイスを消す
	for slot_array: Array[DiceSlot] in slot_arrays:
		for slot: DiceSlot in slot_array:
			slot.remove_dice()


func check_game_is_over() -> void:
	if board.is_full():
		Events.game_over.emit()


func game_over() -> void:
	is_started = false
	print("game over")


func game_reset() -> void:
	print("game reset")
	board.clear_dice()


func on_slot_pressed(slot: DiceSlot) -> void:
	if not slot.has_dice():
		set_current_dice(slot)


func get_hand(slots: Array[DiceSlot]) -> int:
	var nums: Array[int] = []
	for s in slots:
		nums.append(s.dice.pips)
	nums.sort()
	print(nums)
	
	if nums == [1, 2, 3]:
		return HANDS.HIFUMI
	if nums == [4, 5, 6]:
		return HANDS.SHIGORO
	
	match nums.count(nums[1]):
		3:
			if nums[0] == 1:
				return HANDS.PINZORO
			return HANDS.ARASHI
		2:
			return HANDS.DEME
	
	return HANDS.MENASHI
