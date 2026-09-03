# res://src/scenes/menu/menu_panel.gd
extends Control

@onready var btn_simulation: Button = $VBoxMenu/BtnSimular
@onready var btn_config: Button = $VBoxMenu/BtnConfig
@onready var btn_credits: Button = $VBoxMenu/BtnCredits
@onready var btn_exit: Button = $VBoxMenu/BtnSalir

# Referencias a las funciones anónimas para poder desconectarlas
var _simulation_callback: Callable
var _config_callback: Callable
var _credits_callback: Callable
var _exit_callback: Callable

func _ready() -> void:
	print("MenuPanel: Conectando botones...")
	
	# Crear las funciones anónimas y guardarlas
	_simulation_callback = func() -> void:
		print("MenuPanel: Solicitando navegación a simulación")
		EventBus.navigation_requested.emit("res://src/scenes/simulation/step_1_base.tscn")
	
	_config_callback = func() -> void:
		print("MenuPanel: Solicitando navegación a configuración")
		EventBus.navigation_requested.emit("res://src/scenes/config/config_panel.tscn")
	
	_credits_callback = func() -> void:
		print("MenuPanel: Solicitando navegación a créditos")
		EventBus.navigation_requested.emit("res://src/scenes/credits/credits_panel.tscn")
	
	_exit_callback = func() -> void:
		print("MenuPanel: Cerrando aplicación")
		get_tree().quit()
	
	# Conectar
	btn_simulation.pressed.connect(_simulation_callback)
	btn_config.pressed.connect(_config_callback)
	btn_credits.pressed.connect(_credits_callback)
	btn_exit.pressed.connect(_exit_callback)

# ¡NUEVO! Desconectar señales al salir
func _exit_tree() -> void:
	print("MenuPanel: Desconectando botones...")
	btn_simulation.pressed.disconnect(_simulation_callback)
	btn_config.pressed.disconnect(_config_callback)
	btn_credits.pressed.disconnect(_credits_callback)
	btn_exit.pressed.disconnect(_exit_callback)
