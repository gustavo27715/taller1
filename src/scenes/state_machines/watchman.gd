# res://src/scenes/state_machines/watchman.gd
extends Node2D

var enemy = null

func _on_area_2d_area_entered(area: Area2D) -> void:
	$StateChart.send_event("enemy_entered")
	enemy = area.get_parent()

func _on_area_2d_area_exited(area: Area2D) -> void:
	$StateChart.send_event("enemy_exited")

func _on_observing_state_processing(delta: float) -> void:
	look_at(enemy.global_position)
