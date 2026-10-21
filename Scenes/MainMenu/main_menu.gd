extends Node2D


func _on_button_endless_pressed() -> void:
	ChangeScene.to_endless()


func _on_button_roguelike_pressed() -> void:
	ChangeScene.to_roguelike()
