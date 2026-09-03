# res://src/scenes/config/config_panel.gd
extends Control

@onready var btn_back: Button = $BtnBack

var _back_callback: Callable

func _ready() -> void:
	print("ConfigPanel: Conectando botón volver...")
	
	_back_callback = func() -> void:
		print("ConfigPanel: Solicitando volver al menú")
		EventBus.navigation_requested.emit("res://src/scenes/menu/menu_panel.tscn")
	
	btn_back.pressed.connect(_back_callback)

func _exit_tree() -> void:
	print("ConfigPanel: Desconectando botón volver...")
	btn_back.pressed.disconnect(_back_callback)
