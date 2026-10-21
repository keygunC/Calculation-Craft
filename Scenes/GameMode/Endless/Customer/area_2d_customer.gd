extends Area2D


signal customer_interact


func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("give_to_customer"):
		customer_interact.emit()
	elif event.is_action_pressed("mouse_click"):
		customer_interact.emit()
