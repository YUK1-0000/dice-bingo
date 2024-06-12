class_name Board extends Control

@export var slots: Array[DiceSlot]

@onready var grid: GridContainer = $GridContainer
@onready var dice_slots_ui = grid.get_children() as Array[DiceSlot]


func _ready() -> void:
	
	# boardとgridの設定
	slots.resize(25)
	grid.columns = 5
	
	# gridにDiseSlotの追加とアップデート
	var slot: DiceSlot
	for _i in slots.size():
		slot = preload("res://dice_slot.tscn").instantiate()
		grid.add_child(slot)
		slot.update()
