extends Node2D


signal signal_round_complete
signal signal_enemy_clicked(enemy: Enemy)


@onready var work_station := %WorkStation
@onready var enemy_space := %EnemySpace


var game_effect_context: GameEffectContext


var enemy_count: int:
	set(value):
		enemy_count = value

		if enemy_count <= 0:
			signal_round_complete.emit()


############
## Summon ##
############


func summon_fox() -> void:
	work_station.new_materials(2)
	
	var fox_instance = instantiate_fox()
	fox_instance.position = Vector2(360, 320)
	enemy_space.add_child(fox_instance)
	
	enemy_count = 1


func summon_foxes() -> void:
	work_station.new_materials(3)
	
	for coord in [
		Vector2(128, 320),
		Vector2(360, 320),
		Vector2(592, 320),
	]:
		var fox_instance = instantiate_fox()
		fox_instance.position = coord
		enemy_space.add_child(fox_instance)
	
	enemy_count = 3


func summon_dung_beetle() -> void:
	work_station.new_materials(2)
	
	var dung_beetle_instance = instantiate_dung_beetle()
	dung_beetle_instance.position = Vector2(360, 320)
	enemy_space.add_child(dung_beetle_instance)
	
	enemy_count = 1


func summon_dung_beetles() -> void:
	work_station.new_materials(3)
	
	for coord in [
		Vector2(128, 320),
		Vector2(360, 320),
		Vector2(592, 320),
	]:
		var dung_beetle_instance = instantiate_dung_beetle()
		dung_beetle_instance.position = coord
		enemy_space.add_child(dung_beetle_instance)
	
	enemy_count = 3


func summon_random() -> void:
	var summon_list: Array[Callable] = [
		Callable(self, "summon_fox"),
		Callable(self, "summon_foxes"),
		Callable(self, "summon_dung_beetle"),
		Callable(self, "summon_dung_beetles"),
	]
	
	summon_list[randi() % (summon_list.size())].call()


###################
## Instantiation ##
###################


func instantiate_fox() -> Node:
	var fox_scene: PackedScene = preload("res://Scenes/GameMode/Roguelike/Enemies/fox.tscn")
	var fox_instance: Enemy = fox_scene.instantiate()
	
	fox_instance.game_effect_context = game_effect_context
	fox_instance.connect("signal_clicked", _on_enemy_clicked)
	fox_instance.connect("signal_dies", _on_dies)
	
	return fox_instance


func instantiate_dung_beetle() -> Node:
	var dung_beetle_scene: PackedScene = preload("res://Scenes/GameMode/Roguelike/Enemies/dung_beetle.tscn")
	var dung_beetle_instance: Enemy = dung_beetle_scene.instantiate()
	
	dung_beetle_instance.game_effect_context = game_effect_context
	dung_beetle_instance.connect("signal_clicked", _on_enemy_clicked)
	dung_beetle_instance.connect("signal_dies", _on_dies)
	
	return dung_beetle_instance


func _on_enemy_clicked(enemy: Enemy) -> void:
	signal_enemy_clicked.emit(enemy)


func _on_dies(_enemy: Enemy) -> void:
	enemy_count -= 1
