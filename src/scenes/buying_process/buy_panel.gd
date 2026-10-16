# res://src/scenes/simulation/step_1_base.gd
extends Control

@onready var btn_base1: Button = $VBoxContainer/GridContainer/BtnBase1
@onready var btn_base2: Button = $VBoxContainer/GridContainer/BtnBase2
@onready var btn_item1: Button = $VBoxContainer/GridContainer/BtnItem1
@onready var btn_item2: Button = $VBoxContainer/GridContainer/BtnItem2
@onready var lbl_total: Label = $VBoxContainer/LblTotal
@onready var lbl_remaining: Label = $VBoxContainer/LblRemaining
@onready var lbl_budget: Label = $VBoxContainer/LblBudget

func _ready() -> void:
	btn_base1.pressed.connect(_on_base_pressed.bind("base_1"))
	btn_base2.pressed.connect(_on_base_pressed.bind("base_2"))
	btn_item1.pressed.connect(_on_item_pressed.bind("item_1"))
	btn_item2.pressed.connect(_on_item_pressed.bind("item_2"))
	
	EventBus.total_changed.connect(_on_total_changed)
	EventBus.budget_changed.connect(_on_budget_changed)
	
	# Inicializar
	lbl_budget.text = "💰 Presupuesto: $" + str(GlobalManager.monthly_budget)
	_on_total_changed(GlobalManager.current_total)
	_on_budget_changed(GlobalManager.remaining_budget)

func _on_base_pressed(base_name: String) -> void:
	EventBus.base_selected.emit(base_name)

func _on_item_pressed(item_name: String) -> void:
	EventBus.item_added.emit(item_name)

func _on_total_changed(new_total: int) -> void:
	lbl_total.text = "Total gastado: $" + str(new_total)

func _on_budget_changed(remaining: int) -> void:
	lbl_remaining.text = "Disponible: $" + str(remaining)
	
	# Cambiar color si se pasa del presupuesto
	if remaining < 0:
		lbl_remaining.modulate = Color(1, 0, 0)  # Rojo
	elif remaining < 5000:
		lbl_remaining.modulate = Color(1, 0.5, 0)  # Naranja
	else:
		lbl_remaining.modulate = Color(1, 1, 1)  # Blanco
