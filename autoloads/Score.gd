extends Node

var score: int = 0
var hands: Dictionary = {
	"Triple": 3,
	"4-5-6": 2,
	"Points": 1,
	"1-2-3": -1,
	"Indeterminate": 0
}


func update() -> void:
	print("score update")
	
	# boardのdiceのpipsの合計をscoreに代入
	var tmp: int
	for slot: DiceSlot in Game.board.slots:
		tmp += slot.dice.pips
	score = tmp


func check_combinations_of(dice: Array[Dice]) -> void:
	pass
