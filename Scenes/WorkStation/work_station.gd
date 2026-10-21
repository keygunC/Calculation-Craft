extends Node2D


var initial_inventory = []	## The initial inventory if you need to reset
var selected_slot : Slot = null:
	set(value):
		# Applies selection toggle visualisation change
		if value == null:
			selected_slot.selection_toggle(false)
		else:
			value.selection_toggle(true)
		selected_slot = value

@onready var inventory := %Inventory
@onready var tools := %Tools


func _ready():
	await get_tree().process_frame
	
	# Connect slots from workstation
	register_slots(inventory.get_slot_list())
	
	# Connect slots from 
	for child in tools.get_children():
		if child is SlotsContainer:
			register_slots(child.get_slot_list())


## Connects every slot's selection signal from a slot list
func register_slots(slot_list: Array[Slot]) -> void:
	for slot in slot_list:
		slot.connect("signal_slot_selected", _on_signal_slot_selected)


## Empty all slot
func empty_all_slots() -> void:
	inventory.empty_inventory()
	
	for child in tools.get_children():
		if child is SlotsContainer:
			child.empty_inventory()


## Get a new set of materials
func new_materials(list_length: int = 0) -> void:
	# Empty everything
	empty_all_slots()
	initial_inventory = []
	
	# Create randomized initial inventory
	if not list_length:
		list_length = clamp(int(floor(pow(randf(), 1.5) * 6)) + 2, 2, 7) # Weighted random, skew to low
	
	initial_inventory.append([Matherial.TYPE.NUMBER, randi_range(1, 9)])
	
	for _i in range(list_length):
		var new_operator = randi_range(0, len(Matherial.OPERATOR) -1)
		initial_inventory.append([Matherial.TYPE.OPERATOR, new_operator as Matherial.OPERATOR])
		
		var new_number = randi_range(1, 9)
		initial_inventory.append([Matherial.TYPE.NUMBER, new_number])
	
	# Apply initial inventory
	for mtr in initial_inventory:
		inventory.add_material(mtr[0], mtr[1])


## Move a content from one slot to another
func try_move(slot_from: Slot, slot_to: Slot) -> void:
	if (
		(slot_from == slot_to)			# Can't move to the same slot
		or (slot_to.content != null)	# Can't move to a non-empty slot
	):
		return
	
	if slot_from.type in slot_to.accepts:
		# Copy over and Remove previous
		slot_to.change(slot_from.type, slot_from.content)
		slot_from.change()
		
	else:
		print("Workstation: slot_to does not accept such type")


## Resets the materials into initial materials
func reset() -> void:
	empty_all_slots()
	
	# Re-apply initial inventory
	for mtr in initial_inventory:
		inventory.add_material(mtr[0], mtr[1])


## Selection state
func _on_signal_slot_selected(slot: Slot) -> void:
	if selected_slot == null:
		if slot.content != null:
			selected_slot = slot
	else:
		try_move(selected_slot, slot)
		selected_slot = null
