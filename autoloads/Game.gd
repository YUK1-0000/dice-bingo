extends Node

@onready var main: Node = get_tree().root.get_node("Main")
@onready var menus = main.get_node("Menus") as Menus
@onready var board = main.get_node("Board") as Board
@onready var current_dice_slot = main.get_node("CurrentDiceSlot") as DiceSlot

var score: int
var current_dice: Dice
var dice: Array[Dice] = [
	preload("res://resources/dice/dice_1.tres"),
	preload("res://resources/dice/dice_2.tres"),
	preload("res://resources/dice/dice_3.tres"),
	preload("res://resources/dice/dice_4.tres"),
	preload("res://resources/dice/dice_5.tres"),
	preload("res://resources/dice/dice_6.tres")
]


func _ready() -> void:
	Events.turn_begin.connect(dice_roll)
	Events.slot_pressed.connect(set_current_dice)
	Events.turn_end.connect(check_game_is_over)


func _process(_delta: float) -> void:
	if not current_dice:
		Events.turn_begin.emit()


func dice_roll() -> void:
	print("dice roll")
	current_dice = dice.pick_random()
	current_dice_slot.set_dice(current_dice)


func set_current_dice(slot: DiceSlot) -> void:
	
	# クリックされたDiceSlotにcurrent_diceをセットしてターンエンド
	slot.set_dice(current_dice)
	remove_current_dice()
	Events.turn_end.emit()


func remove_current_dice() -> void:
	current_dice = null
	current_dice_slot.remove_dice()


func update_score() -> void:
	print("update score")
	# boardのdiceのpipsの合計をscoreに代入
	var i: int
	for slot: DiceSlot in board.slots:
		i += slot.dice.pips
	score = i


func check_game_is_over() -> void:
	if board.is_full():
		game_over()


func game_over() -> void:
	print("game over")
	update_score()
	menus.show_result_menu()
