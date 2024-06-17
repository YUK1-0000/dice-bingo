extends Node

signal game_start
signal turn_begin
signal slot_pressed(slot: DiceSlot)
signal turn_end
signal get_bingo
signal game_over
signal game_reset

signal get_score(score: int)


func _ready() -> void:
	game_start.connect(func(): Game.is_started = true)
	turn_begin.connect(Game.roll_dice)
	slot_pressed.connect(Game.on_slot_pressed)
	turn_end.connect(Game.end_turn)
	game_over.connect(Game.game_over)
	game_reset.connect(Game.game_reset)
	
	
