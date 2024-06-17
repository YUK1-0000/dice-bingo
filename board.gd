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
	
	var slot_arrays: Array[Array] = []
	
	for i in length:
		for f in [
			
			# 垂直方向に並ぶスロットを示す関数
			func(slot: DiceSlot) -> bool:
				return slot.coords.x == i,
			
			# 水平方向に並ぶスロットを示す関数
			func(slot: DiceSlot) -> bool:
				return slot.coords.y == i
		]:
			
			# 関数fを満たすスロットの配列を追加
			slot_arrays.append(slots.filter(f))
	
	for f in [
		
		# 斜め（左上から右下）方向に並ぶスロットを示す関数
		func(slot: DiceSlot) -> bool:
			return slot.coords.x == slot.coords.y,
		
		# 斜め（右上から左下）方向に並ぶスロットを示す関数
		func(slot: DiceSlot) -> bool:
			return slot.coords.x == length - 1 - slot.coords.y
	]:
		
		# 関数fを満たすスロットの配列を追加
		slot_arrays.append(slots.filter(f))
	
	# ダイスが全てのスロットにある配列のみ戻り値にする
	var ret := slot_arrays.filter(
		func(array: Array) -> bool:
			return array.all(
				func(slot: DiceSlot) -> bool:
					return slot.has_dice()
			)
	)
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
