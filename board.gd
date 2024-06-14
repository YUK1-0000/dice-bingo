class_name Board extends Control

@export var length: int

@onready var grid: GridContainer = $GridContainer

var slots: Array


func _ready() -> void:
	
	# boardとgridの設定
	slots.resize(length ** 2)
	grid.columns = length
	
	# gridにDiseSlotの追加とアップデート
	var slot: DiceSlot
	for _i in slots.size():
		slot = preload("res://dice_slot.tscn").instantiate()
		grid.add_child(slot)
		slot.update()
	
	# slotsに上の変更を反映
	slots = grid.get_children()


func is_full() -> bool:
	
	# slotsの全てがdiceを持つかどうか
	return slots.all(
		func(slot: DiceSlot) -> bool:
			return slot.has_dice()
	)


func clear_dice() -> void:
	for slot: DiceSlot in slots:
		slot.remove_dice()


func get_neighbors() -> void:
	pass
