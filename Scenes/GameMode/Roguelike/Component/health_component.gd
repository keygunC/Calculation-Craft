class_name Health
extends Node


signal signal_health_changed(health_num: int)


@export var health: int = 20
@export var health_max: int = 20


## Changes health amount
func change_health(num: int) -> void:
	health = clampi(health + num, 0, health_max)
	signal_health_changed.emit(health)
