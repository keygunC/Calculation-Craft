extends SlotsContainer


@onready var slot_arg1 := $Argument1
@onready var slot_op := $Operator
@onready var slot_arg2 := $Argument2
@onready var slot_res := $Result


## Calculate and create
func calculate() -> void:
	# Get all input
	var arg1 = slot_arg1.content
	var op = slot_op.content
	var arg2 = slot_arg2.content
	
	if (
		arg1 == null or op == null or arg2 == null	# Any arguments empty
		or slot_res.content							# Result is not empty
	):
		print("Equation: Equation invalid")
		return
	
	# Calculate result
	var res = Matherial.calculate(arg1, op, arg2)
	
	# Remove all input, create slot_res
	slot_arg1.change()
	slot_op.change()
	slot_arg2.change()
	slot_res.change(Matherial.TYPE.NUMBER, res)

## Get all slot lists
func get_slot_list() -> Array[Slot]:
	return [
		slot_arg1,
		slot_op,
		slot_arg2,
		slot_res,
	]


## Empty all slots
func empty_inventory() -> void:
	for slot in [
		slot_arg1,
		slot_op,
		slot_arg2,
		slot_res,
	]:
		slot.change()


func _on_equals_pressed() -> void:
	calculate()
