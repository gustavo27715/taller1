#res://src/scenes/gamification/pizza_rush/delivery_area.gd
extends Area2D

signal pizza_delivered

func confirm_delivery() -> void:
	pizza_delivered.emit()
