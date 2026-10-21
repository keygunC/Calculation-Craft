extends Node2D


@onready var equation := %Equation
@onready var cloner := %Cloner
@onready var splitter := %Splitter


func _on_button_equation_pressed() -> void:
	for child in get_children():
		child.visible = false
	
	equation.visible = true


func _on_button_cloner_pressed() -> void:
	for child in get_children():
		child.visible = false
	
	cloner.visible = true


func _on_button_splitter_pressed() -> void:
	for child in get_children():
		child.visible = false
	
	splitter.visible = true
