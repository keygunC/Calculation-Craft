extends Node


func to_main_menu() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu/main_menu.tscn")


func to_endless() -> void:
	get_tree().change_scene_to_file("res://Scenes/GameMode/Endless/endless.tscn")


func to_roguelike() -> void:
	get_tree().change_scene_to_file("res://Scenes/GameMode/Roguelike/roguelike.tscn")
