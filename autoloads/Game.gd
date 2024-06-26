extends Node

@onready var main: Node = get_tree().root.get_node("Main")
@onready var board = main.get_node("Board") as Board
@onready var current_dice_slot = main.get_node("CurrentDiceSlot") as DiceSlot

var is_started: bool = false
var score: int = 0
var current_dice: Dice = null
var dice: Array[Dice] = [
	preload("res://resources/dice/dice_1.tres"),
	preload("res://resources/dice/dice_2.tres"),
	preload("res://resources/dice/dice_3.tres"),
	preload("res://resources/dice/dice_4.tres"),
	preload("res://resources/dice/dice_5.tres"),
	preload("res://resources/dice/dice_6.tres")
]
var players: int = 2
var player: int = 0
var colors: Array[Color] = [
	Color.html("#55ACFF"),
	Color.html("#FF5457")
]


func _ready() -> void:
	Events.game_start.connect(func(): is_started = true)
	Events.turn_begin.connect(roll_dice)
	Events.slot_pressed.connect(on_slot_pressed)
	Events.turn_end.connect(end_turn)
	Events.game_over.connect(game_over)
	Events.game_reset.connect(game_reset)


func _process(_delta: float) -> void:
	if is_started and not current_dice:
		Events.turn_begin.emit()


func roll_dice() -> void:
	print("dice roll")
	current_dice = dice.pick_random()
	current_dice_slot.set_dice(current_dice)
	current_dice_slot.set_color(colors[player])


func set_current_dice(slot: DiceSlot) -> void:
	print(board.get_neighbors_slot_of(slot).map(
		func(s: DiceSlot) -> Vector2:
			return s.coords)
	)
	
	# クリックされたDiceSlotにcurrent_diceをセットして色を付けてターンエンド
	slot.set_dice(current_dice)
	slot.set_color(colors[player])
	remove_current_dice()
	Events.turn_end.emit()


func remove_current_dice() -> void:
	current_dice = null
	current_dice_slot.remove_dice()


func update_score() -> void:
	print("update score")
	
	# boardのdiceのpipsの合計をscoreに代入
	var tmp: int
	for slot: DiceSlot in board.slots:
		tmp += slot.dice.pips
	score = tmp


func on_slot_pressed(slot: DiceSlot) -> void:
	if not slot.has_dice():
		set_current_dice(slot)


func end_turn() -> void:
	check_game_is_over()
	turn_change()


func turn_change() -> void:
	player = (player + 1) % players


func check_game_is_over() -> void:
	if board.is_full():
		Events.game_over.emit()


func game_over() -> void:
	is_started = false
	print("game over")
	update_score()


func game_reset() -> void:
	print("game reset")
	board.clear_dice()
