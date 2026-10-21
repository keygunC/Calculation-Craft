class_name EffectList
extends Node


@export var effects: Array[GameEffect] ## List of effects that activates under certain conditions


## Executes all game effects
func execute(context: GameEffectContext) -> void:
	for effect in effects:
		effect.execute(context)
