extends Sprite2D


## List of all customer sprites to cycle through
const customer_sprite_list = [
	preload("res://Assets/Customers/Customer1.png"),
	preload("res://Assets/Customers/Customer2.png"),
	preload("res://Assets/Customers/Customer3.png"),
	preload("res://Assets/Customers/Customer4.png"),
]

var current_customer_sprite: int = -1	## Selected index of customer sprite list


func _ready() -> void:
	get_next_customer_sprite()


## Display a different customer sprite
func get_next_customer_sprite() -> void:
	var new_customer_sprite = randi_range(0, len(customer_sprite_list) - 1)
	
	while new_customer_sprite == current_customer_sprite:
		new_customer_sprite = randi_range(0, len(customer_sprite_list) - 1)
	
	current_customer_sprite = new_customer_sprite
	texture = customer_sprite_list[current_customer_sprite]
