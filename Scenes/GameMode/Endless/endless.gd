extends Node2D


# State
var customer_request: int		## Customer's request
var customer_solution: String	## DEBUG: It's just to show how customer calculated the request
var score: int = 0:				## Total amount of successful commissions
	set(value):
		label_score.text = str(value)
		score = value

@onready var label_score := %LabelScore
@onready var label_request := %LabelRequest
@onready var sprite_2d_customer := %Sprite2DCustomer
@onready var work_station := %WorkStation


func _ready():
	# Cover up the processing
	%LoadingCover.visible = true
	await get_tree().process_frame
	%LoadingCover.visible = false
	
	# Initial customer
	new_customer()


## Get a new set of materials and request
func new_customer() -> void:
	work_station.new_materials()
	
	get_customer_request()
	
	sprite_2d_customer.get_next_customer_sprite()


## Calculate customer request from available materials
func get_customer_request() -> void:
	# Filter and separate materials
	var number_list = []
	var operator_list = []
	
	for mtr in work_station.initial_inventory:
		match mtr[0]:
			Matherial.TYPE.NUMBER:
				number_list.append(mtr[1])
			Matherial.TYPE.OPERATOR:
				operator_list.append(mtr[1])
	
	# Loop calculation until a good request
	var is_request_good := false
	var new_customer_request: int
	var new_customer_solution: String = ""
	
	while not is_request_good:
		# Randomize material order
		number_list.shuffle()
		operator_list.shuffle()
		
		new_customer_solution = str(number_list[0])
		
		# Calculate a valid request
		new_customer_request = number_list[0]
		for i in len(operator_list):
			# Increasingly rarer to use more operation
			if i > randi_range(1, len(operator_list)):
				break
			new_customer_request = Matherial.calculate(new_customer_request, operator_list[i], number_list[i+1])
			new_customer_solution += Matherial.OPERATOR_STRING[operator_list[i]] + str(number_list[i+1])
		
		# At least it's not LITERALLY one of the raw material or zero (it'd be boring)
		# TODO: Warning! this could technically softlock if all operator is divide
		if (new_customer_request != 0) and (new_customer_request not in number_list):
			is_request_good = true
		
	# Update and visualize
	customer_request = new_customer_request
	customer_solution = new_customer_solution
	label_request.text = str(customer_request)


## Interacts with the customer
func _on_area_2d_customer_customer_interact() -> void:
	if work_station.selected_slot:
		if work_station.selected_slot.content == customer_request:
			score += 1
			new_customer()
			
			work_station.selected_slot = null


## Return to menu
func _on_button_menu_pressed() -> void:
	ChangeScene.to_main_menu()


## DEBUG: Display solution
func _on_button_solution_pressed() -> void:
	label_score.text = customer_solution


## Reset the work station
func _on_button_reset_pressed() -> void:
	work_station.reset()
