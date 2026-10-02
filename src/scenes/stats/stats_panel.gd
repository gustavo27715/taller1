# res://src/scenes/stats/stats_panel.gd
extends Control

const NAMES := {
	"base_1": "🥗 Comida Saludable",
	"base_2": "🍔 Comida Rápida",
	"item_1": "🥦 Vegetales Extra",
	"item_2": "🥤 Bebida Azucarada"
}

@onready var lbl_purchased: Label = $VBoxContainer/LblPurchased
@onready var lbl_stats: Label = $VBoxContainer/LblStats

func _ready() -> void:
	_show_purchased()
	_show_stats()

func _show_purchased() -> void:
	var lines: Array[String] = []
	for id in NAMES:
		var qty: int = GlobalManager.purchased[id]
		if qty > 0:
			lines.append("%s × %d" % [NAMES[id], qty])
	
	if lines.is_empty():
		lbl_purchased.text = "Aún no has comprado nada."
	else:
		lbl_purchased.text = "\n".join(lines)

func _show_stats() -> void:
	var total: Dictionary = GlobalManager.get_total_stats()
	lbl_stats.text = (
		"Salud: %+d\n"
		+ "Velocidad: %+d\n"
		+ "Salto: %+d\n"
		+ "Energía: %+d"
	) % [total["salud"], total["velocidad"], total["salto"], total["energia"]]
