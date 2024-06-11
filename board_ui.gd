extends Control

@export var board: Board

@onready var grid: GridContainer = $GridContainer
@onready var dice_slots_ui = grid.get_children() as Array[DiceSlotUI]


func _ready() -> void:
	
	# boardとgridの設定
	board.slots.resize(25)
	grid.columns = 5
	
	# board.slotsのリソース配置
	for slot: DiceSlot in board.slots:
		slot = DiceSlot.new()
	
	# gridにDiseSlotUIを追加
	var slot_ui: DiceSlotUI
	for _i in board.slots.size():
		slot_ui = preload("res://dice_slot_ui.tscn").instantiate()
		slot_ui.slot = DiceSlot.new()
		grid.add_child(slot_ui)
