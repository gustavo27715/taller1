#res://src/scenes/gamification/pizza_rush/pizza_rush_main.gd
extends Node2D

@export var target_pizzas: int = 5
@export var coupon_value: int = 5000
@export var coupon_minimum_value: int = 9000

var pizzas_delivered: int = 0
var game_finished: bool = false

@onready var delivery_area: Area2D = $DeliveryArea
@onready var timer_gameover: Timer = $TimerGameover
@onready var lbl_pizza_count: Label = $CanvasLayer/LabelPizzaCount
@onready var lbl_timer: Label = $CanvasLayer/LabelTimeCounter
@onready var panel: Panel = $CanvasLayer/Panel

func _ready() -> void:
	delivery_area.pizza_delivered.connect(_on_pizza_delivered)
	timer_gameover.timeout.connect(_on_general_timer_timeout)
	timer_gameover.start()
	_update_pizza_label()

func _process(_delta: float) -> void:
	if not game_finished:
		lbl_timer.text = "Tiempo: %d" % timer_gameover.time_left

func _update_pizza_label() -> void:
	lbl_pizza_count.text = "Pizzas: %d / %d" % [pizzas_delivered, target_pizzas]

func _on_pizza_delivered() -> void:
	if game_finished:
		return
	pizzas_delivered += 1
	_update_pizza_label()
	if pizzas_delivered >= target_pizzas:
		finish_game()
	else:
		var spawns: Array = get_tree().get_nodes_in_group("pizza_spawn")
		var free_spawns: Array = spawns.filter(func(s): return s.is_free())
		if free_spawns.size() > 0:
			free_spawns.pick_random().spawn_pizza()

func _on_general_timer_timeout() -> void:
	if game_finished:
		return
	_end_round()
	show_panel("Pedido incompleto", "Se agotó el tiempo.",
		"Pizzas entregadas: " + str(pizzas_delivered) + " / " + str(target_pizzas))
	print("gameover")

func finish_game() -> void:
	_end_round()
	show_panel("¡Pedido completado!", "Has entregado todas las pizzas.",
		"Pizzas entregadas: " + str(pizzas_delivered) + " / " + str(target_pizzas))
	var coupon: Dictionary = {
		"value": coupon_value,
		"minimum_purchase": coupon_minimum_value
	}
	EventBus.coupon_obtained.emit(coupon)
	print("Partida completada")

# Flujo común de cierre: temporizador, interacciones y HUD.
func _end_round() -> void:
	game_finished = true
	timer_gameover.stop()
	for pizza in get_tree().get_nodes_in_group("pizza"):
		pizza.lock()
	hide_hud()

func hide_hud() -> void:
	lbl_timer.hide()
	lbl_pizza_count.hide()

func show_panel(title: String, desc: String, count: String) -> void:
	panel.show()
	$CanvasLayer/Panel/VBoxContainer/LabelTitle.text = title
	$CanvasLayer/Panel/VBoxContainer/LabelDesc.text = desc
	$CanvasLayer/Panel/VBoxContainer/LabelCount.text = count
