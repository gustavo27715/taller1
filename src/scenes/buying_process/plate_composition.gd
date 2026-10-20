# res://src/scenes/buying_process/plate_composition.gd
extends Control

enum PlateHalf {
	LEFT,
	RIGHT
}

var selected_half: PlateHalf = PlateHalf.LEFT
var left_food: FoodData
var right_food: FoodData

@onready var left_flavor_rect: TextureRect = $LeftFlavor
@onready var right_flavor_rect: TextureRect = $RightFlavor
@onready var left_half_button: Button = $LeftFlavor/Button
@onready var right_half_button: Button = $RightFlavor/Button
@onready var left_selection: ColorRect = $LeftFlavor/Selection
@onready var right_selection: ColorRect = $RightFlavor/Selection

func _ready() -> void:
	left_half_button.pressed.connect(_on_left_half_pressed)
	right_half_button.pressed.connect(_on_right_half_pressed)
	_restore_from_state()
	update_selection_visual()

# Si la escena se vuelve a cargar (por ejemplo al regresar desde la factura),
# se reconstruye el plato con lo que ya está guardado en GlobalManager.
func _restore_from_state() -> void:
	left_food = GlobalManager.get_food(GlobalManager.plate_selection["left"])
	right_food = GlobalManager.get_food(GlobalManager.plate_selection["right"])
	if left_food != null:
		left_flavor_rect.texture = left_food.texture
	if right_food != null:
		right_flavor_rect.texture = right_food.texture

func _on_left_half_pressed() -> void:
	selected_half = PlateHalf.LEFT
	update_selection_visual()

func _on_right_half_pressed() -> void:
	selected_half = PlateHalf.RIGHT
	update_selection_visual()

# Señal que recibimos desde buy_panel_interactive.
func _on_food_selected(food: FoodData) -> void:
	if food == null:
		return
	EventBus.food_selected.emit(food.id, selected_half)
	match selected_half:
		PlateHalf.LEFT:
			left_food = food
			left_flavor_rect.texture = food.texture
		PlateHalf.RIGHT:
			right_food = food
			right_flavor_rect.texture = food.texture
	animate_plate_update()

func update_selection_visual() -> void:
	var selected_selection := left_selection if selected_half == PlateHalf.LEFT else right_selection
	var other_selection := right_selection if selected_half == PlateHalf.LEFT else left_selection
	var selected_flavor := left_flavor_rect if selected_half == PlateHalf.LEFT else right_flavor_rect
	var other_flavor := right_flavor_rect if selected_half == PlateHalf.LEFT else left_flavor_rect
	
	var tween := create_tween()
	tween.set_parallel(true)
	
	# Flash de color: aparece y luego queda muy transparente
	tween.tween_property(selected_selection, "color", Color(1.0, 0.85, 0.3, 0.35), 0.10)
	tween.tween_property(selected_selection, "color", Color(1.0, 0.85, 0.3, 0.08), 0.20).set_delay(0.10)
	
	# La otra mitad pierde su selección
	tween.tween_property(other_selection, "color", Color(1.0, 1.0, 1.0, 0.0), 0.12)
	
	# Flash de escala: crece y vuelve a su tamaño normal
	tween.tween_property(selected_flavor, "scale", Vector2(1.04, 1.04), 0.10)
	tween.tween_property(selected_flavor, "scale", Vector2.ONE, 0.10).set_delay(0.10)
	tween.tween_property(other_flavor, "scale", Vector2.ONE, 0.10)

# Efecto de "rebote" al colocar un alimento en la mitad activa
func animate_plate_update() -> void:
	var target := left_flavor_rect if selected_half == PlateHalf.LEFT else right_flavor_rect
	target.scale = Vector2(0.85, 0.85)
	target.modulate = Color(1.0, 1.0, 1.0, 0.0)
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(target, "scale", Vector2.ONE, 0.18)
	tween.tween_property(target, "modulate", Color.WHITE, 0.18)
