# res://src/scenes/buying_process/purchase_invoice_interactive.gd
extends Control

@onready var lbl_subtotal: Label = $VBoxContainer/LblSubtotal
@onready var lbl_stats: Label = $VBoxContainer/LblStats
@onready var lbl_coupon: Label = $VBoxContainer/LblCoupon
@onready var lbl_total: Label = $VBoxContainer/LblTotal
@onready var btn_confirm: Button = $VBoxContainer/BtnConfirm
@onready var pop_up_confirm: Panel = $PurchaseSuccessPopup

var _purchase_confirmed: bool = false

func _ready() -> void:
	btn_confirm.pressed.connect(_on_confirm)
	_update_invoice()

func _on_confirm() -> void:
	if _purchase_confirmed:
		return
	_purchase_confirmed = true
	
	var result = GlobalManager.confirm_plate_purchase()
	
	if result["coupon_applied"]:
		lbl_coupon.text = "✅ Descuento aplicado: -$%d" % result["discount"]
	else:
		lbl_coupon.text = "Sin descuento aplicado"
	
	lbl_total.text = "TOTAL PAGADO: $%d" % result["final_total"]
	btn_confirm.disabled = true
	
	# Feedback visual: comunicar que la compra se realizó
	pop_up_confirm.show()

func _update_invoice() -> void:
	var left_food := GlobalManager.get_food(GlobalManager.plate_selection["left"])
	var right_food := GlobalManager.get_food(GlobalManager.plate_selection["right"])
	
	var left_name := "Sin selección"
	var right_name := "Sin selección"
	var left_price := 0
	var right_price := 0
	if left_food != null:
		left_name = left_food.display_name
		left_price = left_food.price
	if right_food != null:
		right_name = right_food.display_name
		right_price = right_food.price
	
	var subtotal: int = GlobalManager.plate_total
	lbl_subtotal.text = (
		"MITAD IZQUIERDA: %s    $%d\n"
		+ "MITAD DERECHA: %s    $%d\n"
		+ "--------------------------------\n"
		+ "Subtotal: $%d"
	) % [left_name, left_price, right_name, right_price, subtotal]
	
	# Resumen de estadísticas que otorgará el plato
	var s: Dictionary = GlobalManager.get_plate_stats()
	lbl_stats.text = "Estadísticas del plato\n❤️ %+d   ⚡ %+d   🦘 %+d   🔋 %+d" % [
		s["salud"], s["velocidad"], s["salto"], s["energia"]
	]
	
	# Total CON descuento (sin aplicarlo todavía)
	var coupon := GlobalManager.get_best_coupon(subtotal)
	var discount: int = 0
	if not coupon.is_empty():
		discount = coupon["value"]
		lbl_coupon.text = "Descuento a aplicar: -$%d" % discount
	else:
		lbl_coupon.text = "Sin cupón disponible"
	
	lbl_total.text = "TOTAL A PAGAR: $%d" % max(subtotal - discount, 0)
	btn_confirm.disabled = subtotal <= 0
