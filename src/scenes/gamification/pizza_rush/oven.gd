#res://src/scenes/gamification/pizza_rush/oven.gd
extends Area2D

@onready var sprite: Sprite2D = $Sprite2D

func activate() -> void:
	sprite.modulate = Color(1.0, 0.5, 0.3)

func deactivate() -> void:
	sprite.modulate = Color.WHITE
