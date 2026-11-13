# res://src/scenes/buying_process/buy_panel_interactive.gd
extends Control

@onready var lbl_budget: Label = $IngredientScroll/VBoxContainer/LblBudget
@onready var lbl_total: Label = $IngredientScroll/VBoxContainer/LblTotal
@onready var ingredient_list: Container = $IngredientScroll/VBoxContainer/IngredientList
@onready var btn_continue: Button = $IngredientScroll/VBoxContainer/BtnContinue
@onready var lbl_stats: Label = $LblStats

func _ready() -> void:
	# Un botón por cada alimento del catálogo (GlobalManager.foods)
	for food in GlobalManager.foods:
		var button := Button.new()
		button.text = "%s %s ($%d)" % [food.emoji, food.display_name, food.price]
		button.pressed.connect(_on_food_selected.bind(food))
		ingredient_list.add_child(button)
	
	# Señal para actualizar el precio
	EventBus.plate_total_changed.connect(_on_total_changed)
	_on_total_changed(GlobalManager.plate_total)

# Envía el alimento elegido a la composición visual del plato
func _on_food_selected(food: FoodData) -> void:
	$PlateComposition._on_food_selected(food)

func _on_total_changed(new_total: int) -> void:
	lbl_total.text = "Total: $" + str(new_total)
	lbl_budget.text = "💰 Presupuesto: $%d  |  Disponible: $%d" % [
		GlobalManager.monthly_budget,
		GlobalManager.get_plate_available_budget()
	]
	# Avisar visualmente si el plato supera el presupuesto
	lbl_budget.modulate = Color(0.85, 0.25, 0.15) if GlobalManager.get_plate_available_budget() < 0 else Color.WHITE
	
	var s: Dictionary = GlobalManager.get_plate_stats()
	lbl_stats.text = "❤️ %+d   ⚡ %+d   🦘 %+d   🔋 %+d" % [s["salud"], s["velocidad"], s["salto"], s["energia"]]
	
	# No se puede continuar con un plato vacío
	btn_continue.disabled = new_total <= 0
