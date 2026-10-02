#res://src/scenes/gamification/pizza_rush/pizza_spawn.gd
extends Node2D

@export var PIZZA_SCENE: PackedScene
## Desplazamiento inicial para que la pizza caiga sobre la mesa
## en lugar de aparecer dentro de su colisión.
@export var spawn_offset: Vector2 = Vector2(0, -110)

func _ready() -> void:
	spawn_pizza()

func spawn_pizza() -> void:
	var pizza = PIZZA_SCENE.instantiate()
	add_child(pizza)
	pizza.global_position = global_position + spawn_offset
	
func is_free() -> bool:
	for pizza in get_tree().get_nodes_in_group("pizza"):
		if pizza.global_position.distance_to(global_position) < 150.0:
			return false
	return true
