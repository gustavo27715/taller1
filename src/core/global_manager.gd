# res://src/core/global_manager.gd
extends Node

var prices: Dictionary = {
	"base_1": 7000,
	"base_2": 3000,
	"item_1": 1500,
	"item_2": 800
}

var selection: Dictionary = {
	"base_1": 0,
	"base_2": 0,
	"item_1": 0,
	"item_2": 0
}

var coupons: Array[Dictionary] = []
var current_total: int = 0          # Subtotal de la compra actual
var final_total: int = 0            # Total de la compra actual (con descuento)
var applied_coupon: Dictionary = {}
var monthly_budget: int = 20000     # Presupuesto total del mes
var spent_total: int = 0            # ✅ NUEVO: Total gastado acumulado
var remaining_budget: int = 20000   # Presupuesto restante (acumulado)

func _ready() -> void:
	EventBus.coupon_obtained.connect(_on_coupon_obtained)
	EventBus.base_selected.connect(_on_base_selected)
	EventBus.item_added.connect(_on_item_added)
	_update_total()

func _on_base_selected(base_id: String) -> void:
	selection[base_id] += 1
	_update_total()

func _on_item_added(item_id: String) -> void:
	selection[item_id] += 1
	_update_total()

func _on_coupon_obtained(coupon: Dictionary) -> void:
	coupons.append(coupon)

func _update_total() -> void:
	# Calcular subtotal de la compra ACTUAL
	current_total = 0
	current_total += selection["base_1"] * prices["base_1"]
	current_total += selection["base_2"] * prices["base_2"]
	current_total += selection["item_1"] * prices["item_1"]
	current_total += selection["item_2"] * prices["item_2"]
	
	# Buscar cupón válido para esta compra
	applied_coupon = get_best_coupon(current_total)
	
	# Total de la compra actual (sin descuento todavía)
	final_total = current_total
	
	# ✅ Calcular presupuesto restante ACUMULADO
	remaining_budget = monthly_budget - spent_total - current_total
	
	EventBus.total_changed.emit(current_total)
	EventBus.budget_changed.emit(remaining_budget)

# ✅ NUEVA FUNCIÓN: Confirmar compra
func confirm_purchase() -> Dictionary:
	var result := {
		"subtotal": current_total,
		"discount": 0,
		"final_total": current_total,
		"coupon_applied": false
	}
	
	if not applied_coupon.is_empty():
		var discount: int = applied_coupon["value"]
		result["discount"] = discount
		result["final_total"] = max(current_total - discount, 0)
		result["coupon_applied"] = true
		
		# Consumir el cupón
		remove_coupon(applied_coupon)
		applied_coupon = {}
	
	# ✅ ACUMULAR el gasto
	spent_total += result["final_total"]
	remaining_budget = monthly_budget - spent_total
	
	# Resetear la selección para la próxima compra
	selection = {
		"base_1": 0,
		"base_2": 0,
		"item_1": 0,
		"item_2": 0
	}
	current_total = 0
	final_total = 0
	
	# Emitir señales actualizadas
	EventBus.total_changed.emit(current_total)
	EventBus.budget_changed.emit(remaining_budget)
	
	return result

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
