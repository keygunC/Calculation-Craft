extends SlotsContainer


@onready var slot_arg1 := $Argument1
@onready var slot_arg2 := $Argument2


# Create a duplicate of the material
func clone() -> void:
	var arg1 := slot_arg1
	var arg2 := slot_arg2
	
	var type
	var content
	
	if (not arg1.content and not arg2.content):
		print("Cloner: No arguments at all")
		return
	elif (arg1.content and arg2.content):
		print("Cloner: Both slot full")
		return
	elif (arg1.content and not arg2.content):
		type = arg1.type
		content = arg1.content
	elif (not arg1.content and arg2.content):
		type = arg2.type
		content = arg2.content
	
	slot_arg1.change(type, content)
	slot_arg2.change(type, content)


## Get all slot lists
func get_slot_list() -> Array[Slot]:
	return [
		slot_arg1,
		slot_arg2,
	]


## Empty all slots
func empty_inventory() -> void:
	for slot in [
		slot_arg1,
		slot_arg2,
	]:
		slot.change()


func _on_clone_pressed() -> void:
	clone()
