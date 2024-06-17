class_name Board extends Control

@export var length: int = 0

@onready var grid = $GridContainer as GridContainer

var slots: Array[DiceSlot] = []


func _ready() -> void:
	
	# DiceSlotを配置して座標を設定
	grid.columns = length
	
	var slot: DiceSlot
	for y in length:
		for x in length:
			slot = preload("res://dice_slot.tscn").instantiate()
			slot.coords = Vector2(x, y)
			grid.add_child(slot)
			slots.append(slot)
			slot.update()


func is_full() -> bool:
	
	# slotsの全てがdiceを持つかどうか
	return slots.all(
		func(slot: DiceSlot) -> bool:
			return slot.has_dice()
	)


func get_bingo_slots() -> Array[Array]:
	
	var ret: Array[Array] = []
	var tmp: Array[DiceSlot] = []
	for i in length:
		
		# 垂直方向のビンゴの取得し、戻り値に追加
		tmp = slots.filter(
			func(slot: DiceSlot) -> bool:
				return slot.coords.x == i and slot.has_dice()
		)
		if tmp.size() == length:
			ret.append(tmp)
		
		# 水平方向のビンゴを取得し、戻り値に追加
		tmp = slots.filter(
			func(slot: DiceSlot) -> bool:
				return slot.coords.y == i and slot.has_dice()
		)
		if tmp.size() == length:
			ret.append(tmp)
	
	# 左上から右下方向のビンゴを取得し、戻り値に追加
	tmp = slots.filter(
		func(slot: DiceSlot) -> bool:
			return slot.coords.x == slot.coords.y and slot.has_dice()
	)
	if tmp.size() == length:
		ret.append(tmp)
	
	# 右上から左下方向のビンゴを取得し、戻り値に追加
	tmp = slots.filter(
		func(slot: DiceSlot) -> bool:
			return slot.coords.x == length - 1 - slot.coords.y and slot.has_dice()
	)
	if tmp.size() == length:
		ret.append(tmp)
	
	print("bingo: ", str(ret.size()))
	print("bingo slots: ", ret)
	return ret


func clear_dice() -> void:
	for slot: DiceSlot in slots:
		slot.remove_dice()


# 引数のslotの上下左右のDiceSlotを返す
func get_neighbors_slot_of(slot: DiceSlot) -> Array[DiceSlot]:
	
	var neighbors: Array[DiceSlot] = []
	for slot_: DiceSlot in slots:
		
		# slotとの距離が１のDiceSlotを戻り値に追加
		if slot.coords.distance_to(slot_.coords) == 1:
			neighbors.append(slot_)
	
	return neighbors
