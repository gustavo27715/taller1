# res://src/scenes/credits/credits_panel.gd
extends Control

@onready var btn_back: Button = $BtnBack

var _back_callback: Callable

func _ready() -> void:
	print("CreditsPanel: Conectando botón volver...")
	
	_back_callback = func() -> void:
		print("CreditsPanel: Solicitando volver al menú")
		EventBus.navigation_requested.emit("res://src/scenes/menu/menu_panel.tscn")
	
	btn_back.pressed.connect(_back_callback)

func _exit_tree() -> void:
	print("CreditsPanel: Desconectando botón volver...")
	btn_back.pressed.disconnect(_back_callback)
