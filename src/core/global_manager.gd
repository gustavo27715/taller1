# res://src/core/global_manager.gd
extends Node

var prices: Dictionary = {
	"base_1": 7000,    # Comida Saludable
	"base_2": 3000,    # Comida Rápida
	"item_1": 1500,    # Vegetales Extra
	"item_2": 800      # Bebida Azucarada
}

var selection: Dictionary = {
	"base_1": 0,
	"base_2": 0,
	"item_1": 0,
	"item_2": 0
}

var coupons: Array[Dictionary] = []
var current_total: int = 0
var monthly_budget: int = 20000
var remaining_budget: int = 20000

func _ready() -> void:
	EventBus.coupon_obtained.connect(_on_coupon_obtained)
	EventBus.base_selected.connect(_on_base_selected)
	EventBus.item_added.connect(_on_item_added)
	_update_total()

func _on_base_selected(base_id: String) -> void:
	print("GlobalManager: Base añadida: ", base_id)
	selection[base_id] += 1
	_update_total()

func _on_item_added(item_id: String) -> void:
	print("GlobalManager: Item añadido: ", item_id)
	selection[item_id] += 1
	_update_total()

func _on_coupon_obtained(coupon: Dictionary) -> void:
	print("Cupón obtenido: ", coupon)
	coupons.append(coupon)

func _update_total() -> void:
	current_total = 0
	current_total += selection["base_1"] * prices["base_1"]
	current_total += selection["base_2"] * prices["base_2"]
	current_total += selection["item_1"] * prices["item_1"]
	current_total += selection["item_2"] * prices["item_2"]
	
	remaining_budget = monthly_budget - current_total
	
	print("GlobalManager: Total=", current_total, " Presupuesto=", monthly_budget, " Restante=", remaining_budget)
	EventBus.total_changed.emit(current_total)
	EventBus.budget_changed.emit(remaining_budget)

func get_best_coupon(subtotal: int) -> Dictionary:
	var best_coupon := {}
	for coupon in coupons:
		if subtotal >= coupon["minimum_purchase"]:
			if best_coupon.is_empty():
				best_coupon = coupon
			elif coupon["value"] > best_coupon["value"]:
				best_coupon = coupon
	return best_coupon

func remove_coupon(coupon: Dictionary) -> void:
	if coupon in coupons:
		coupons.erase(coupon)
