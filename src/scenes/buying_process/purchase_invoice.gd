# res://src/scenes/buying_process/purchase_invoice.gd
extends Control

@onready var lbl_subtotal: Label = $VBoxContainer/LblSubtotal
@onready var lbl_coupon: Label = $VBoxContainer/LblCoupon
@onready var lbl_total: Label = $VBoxContainer/LblTotal
@onready var btn_confirm: Button = $VBoxContainer/BtnConfirm

var _purchase_confirmed: bool = false

func _ready() -> void:
	btn_confirm.pressed.connect(_on_confirm)
	_update_invoice()

func _on_confirm() -> void:
	if _purchase_confirmed:
		return
	
	_purchase_confirmed = true
	
	var result = GlobalManager.confirm_purchase()
	
	if result["coupon_applied"]:
		lbl_coupon.text = "✅ Descuento aplicado: -$%d" % result["discount"]
	else:
		lbl_coupon.text = "Sin descuento aplicado"
	
	lbl_total.text = "TOTAL PAGADO: $%d" % result["final_total"]
	btn_confirm.disabled = true

func _update_invoice() -> void:
	var base_1_qty: int = GlobalManager.selection["base_1"]
	var base_2_qty: int = GlobalManager.selection["base_2"]
	var item_1_qty: int = GlobalManager.selection["item_1"]
	var item_2_qty: int = GlobalManager.selection["item_2"]

	var base_1_price: int = GlobalManager.prices["base_1"]
	var base_2_price: int = GlobalManager.prices["base_2"]
	var item_1_price: int = GlobalManager.prices["item_1"]
	var item_2_price: int = GlobalManager.prices["item_2"]

	var base_1_total: int = base_1_qty * base_1_price
	var base_2_total: int = base_2_qty * base_2_price
	var item_1_total: int = item_1_qty * item_1_price
	var item_2_total: int = item_2_qty * item_2_price

	lbl_subtotal.text = (
        "Comida Saludable: %d × $%d    $%d\n"
		+ "Comida Rápida: %d × $%d    $%d\n"
		+ "Vegetales Extra: %d × $%d    $%d\n"
		+ "Bebida Azucarada: %d × $%d    $%d\n"
		+ "--------------------------------\n"
		+ "Subtotal: $%d"
	) % [
		base_1_qty, base_1_price, base_1_total,
		base_2_qty, base_2_price, base_2_total,
		item_1_qty, item_1_price, item_1_total,
		item_2_qty, item_2_price, item_2_total,
		GlobalManager.current_total
	]

	# ✅ Calcular el total CON descuento (sin aplicarlo todavía)
	var available_coupon = GlobalManager.applied_coupon
	var discount: int = 0
	if not available_coupon.is_empty():
		discount = available_coupon["value"]
		lbl_coupon.text = "Descuento a aplicar: -$%d" % discount
	else:
		lbl_coupon.text = "Sin cupón disponible"
	
	var final_total: int = max(GlobalManager.current_total - discount, 0)
	lbl_total.text = "TOTAL A PAGAR: $%d" % final_total
