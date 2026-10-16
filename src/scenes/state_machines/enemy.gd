# res://src/scenes/state_machines/enemy.gd
extends Node2D

func _process(delta: float) -> void:
	global_position = get_global_mouse_position()
