extends SlotsContainer


@onready var slot_arg := $Argument
@onready var slot_res1 := $Result1
@onready var slot_res2 := $Result2


## Get all slot lists
func get_slot_list() -> Array[Slot]:
	return [
		slot_arg,
		slot_res1,
		slot_res2,
	]


## Empty all slots
func empty_inventory() -> void:
	for slot: Slot in [
		slot_arg,
		slot_res1,
		slot_res2,
	]:
		slot.change()


func _on_button_split_pressed() -> void:
	var num_half_ceil: int = ceili(slot_arg.content / 2) # TODO: Probably wrong here
	var num_half_floor: int = floori(slot_arg.content / 2)
	
	slot_arg.change()
	slot_res1.change(Matherial.TYPE.NUMBER, num_half_ceil)
	slot_res2.change(Matherial.TYPE.NUMBER, num_half_floor)
