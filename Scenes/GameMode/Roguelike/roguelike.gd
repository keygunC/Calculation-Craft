extends Node2D


@export var health: Node

@onready var enemy_space := %EnemySpace
@onready var result_screen := %ResultScreen
@onready var health_component := %HealthComponent
@onready var inventory := %Inventory
@onready var work_station := %WorkStation
@onready var label_health := %LabelHealth
@onready var work_buttons := %WorkButtons
@onready var button_work_toggle := %ButtonWorkToggle


func _ready() -> void:
	label_health.text = str(health.health)
	
	await get_tree().process_frame
	
	enemy_space.game_effect_context = create_game_effect_context()
	next_round()


func _input(event: InputEvent) -> void:
	# TODO: debug testing stuff
	if event.is_action_pressed("ui_accept"):
		next_round()


## Get the next round
func next_round() -> void:
	result_screen.visible = false
	enemy_space.summon_random()


## Creates informations and manipulatable variables for game effects
func create_game_effect_context() -> GameEffectContext:
	var new_context := GameEffectContext.new()
	new_context.health = health_component
	new_context.inventory = inventory
	
	return new_context


## updates health label
func _on_health_component_signal_health_changed(health_num: int) -> void:
	label_health.text = str(health_num)


## Toggle work buttons visibility
func _on_button_work_toggle_pressed() -> void:
	# Switch options visibility
	work_buttons.visible = !work_buttons.visible
	
	# Changes symbol between expand/minimize
	if work_buttons.visible:
		button_work_toggle.text = "V"
	else:
		button_work_toggle.text = "^"


## Interacted with an enemy, either giving material or checking info
func _on_enemy_space_signal_enemy_clicked(enemy: Enemy) -> void:
	var selected_slot: Slot = work_station.selected_slot
	
	# Give enemy a number
	if selected_slot and selected_slot.type == Matherial.TYPE.NUMBER:
		var content_given = selected_slot.content
		
		# Removes content first
		work_station.selected_slot.change()
		work_station.selected_slot = null
		
		# Gives content
		enemy.give_number(content_given)
	
	# Show enemy's description
	elif not selected_slot:
		print("TODO: Show the enemy's description")


## Round complete, show result screen
func _on_enemy_space_signal_round_complete() -> void:
	result_screen.visible = true


func _on_button_next_pressed() -> void:
	next_round()


## Return to menu
func _on_button_menu_pressed() -> void:
	ChangeScene.to_main_menu()
