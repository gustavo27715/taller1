# res://src/core/event_bus.gd
extends Node

signal navigation_requested(target_scene: String, discard_previous: bool)
signal base_selected(base_name: String)
signal item_added(item_id: String)
signal total_changed(new_total: int)
signal budget_changed(remaining: int)
signal coupon_obtained(coupon: Dictionary)   # ← NUEVA
signal food_selected(food_id: String, half: int)    # Compra interactiva (plato)
signal plate_total_changed(new_total: int)
