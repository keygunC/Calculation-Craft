extends SlotsContainer


@onready var tile_map_layer := $TileMapLayer


## Get the first empty slot.
## Returns null if all is full
func get_empty_slot():
	for slot in tile_map_layer.get_children():
		if slot.content == null:
			return slot
	
	return null


## Adds material into an empty slot in the inventory
func add_material(materialType: Matherial.TYPE, content) -> void:
	var slot = get_empty_slot()
	if slot != null:
		slot.change(materialType, content)


## Get all slot lists
func get_slot_list() -> Array[Slot]:
	var slot_list: Array[Slot] = []
	for child in tile_map_layer.get_children():
		if child is Slot:
			slot_list.append(child)
	
	return slot_list


## Empty all slots
func empty_inventory() -> void:
	for slot in tile_map_layer.get_children():
		slot.change()
