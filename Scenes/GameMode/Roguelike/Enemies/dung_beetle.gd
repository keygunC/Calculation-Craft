extends Enemy


@onready var label_request := %LabelRequest
@onready var death_effects := %DeathEffects


var request : int = 0:
	set(value):
		request = value
		label_request.text = str(request)


func _ready() -> void:
	request = randi() % 10


func give_number(num: int) -> void:
	game_effect_context.health.change_health(-abs(request - num))
	signal_dies.emit(self)
	death_effects.execute(game_effect_context)
	queue_free()


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("mouse_click"):
		signal_clicked.emit(self)
