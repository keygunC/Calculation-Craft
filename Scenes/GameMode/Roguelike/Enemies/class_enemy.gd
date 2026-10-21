class_name Enemy
extends Node 


signal signal_clicked(enemy: Enemy)
signal signal_dies(enemy: Enemy)


var game_effect_context: GameEffectContext


## Give number to the enemy.
## Let the enemy figure out what to do and respond with signals
func give_number(_num: int) -> void:
	pass


# NOTE: Below functions is just to silence the unused signal warning

func emit_clicked() -> void:
	signal_clicked.emit(self)


func emit_dies() -> void:
	signal_dies.emit(self)
