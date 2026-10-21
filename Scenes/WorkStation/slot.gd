class_name Slot
extends Node2D


signal signal_slot_selected(slot)


# List of acceptable material types into this slot
@export var accepts : Array[Matherial.TYPE] = [
	Matherial.TYPE.NUMBER,
	Matherial.TYPE.OPERATOR,
]

var type := Matherial.TYPE.OPERATOR
var content = null	## Slot's content (int or MATERIALTYPE)

@onready var label_slot := %LabelSlot
@onready var Selection_node := %SelectionNode


## Change slot content
## Default: empty
func change(
	newType: Matherial.TYPE = Matherial.TYPE.NONE,
	newContent = null
):
	self.type = newType
	content = newContent
	label_slot.change(newType, newContent)


## Toggles selection visibility
func selection_toggle(isSelected: bool) -> void:
	Selection_node.visible = isSelected


func _on_button_pressed() -> void:
	signal_slot_selected.emit(self)
