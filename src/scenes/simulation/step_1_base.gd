extends Control

@onready var status_label: Label = $GridContainer/StatusLabel
@onready var btn_volver: Button = $GridContainer/BtnVolver

# Referencias a las funciones anónimas para poder desconectarlas
var _tomate_callback: Callable
var _lechuga_callback: Callable
var _carne_callback: Callable
var _queso_callback: Callable
var _volver_callback: Callable

func _ready() -> void:
	print("Step1Base: Conectando botones...")
	
	# Crear los callbacks para ingredientes
	_tomate_callback = _on_ingrediente_selected.bind("Tomate", 5)
	_lechuga_callback = _on_ingrediente_selected.bind("Lechuga", 3)
	_carne_callback = _on_ingrediente_selected.bind("Carne", 10)
	_queso_callback = _on_ingrediente_selected.bind("Queso", 8)
	
	# Conectar ingredientes
	$GridContainer/BtnTomate.pressed.connect(_tomate_callback)
	$GridContainer/BtnLechuga.pressed.connect(_lechuga_callback)
	$GridContainer/BtnCarne.pressed.connect(_carne_callback)
	$GridContainer/BtnQueso.pressed.connect(_queso_callback)
	
	# Conectar botón volver con EventBus
	_volver_callback = func() -> void:
		print("Step1Base: Solicitando volver al menú")
		EventBus.navigation_requested.emit("res://src/scenes/menu/menu_panel.tscn")
	
	btn_volver.pressed.connect(_volver_callback)

func _on_ingrediente_selected(nombre: String, costo: int) -> void:
	status_label.text = "Selección: %s (+$%d)" % [nombre, costo]
	print("Seleccionaste: %s - Costo: $%d" % [nombre, costo])

# ¡NUEVO! Desconectar señales al salir
func _exit_tree() -> void:
	print("Step1Base: Desconectando botones...")
	$GridContainer/BtnTomate.pressed.disconnect(_tomate_callback)
	$GridContainer/BtnLechuga.pressed.disconnect(_lechuga_callback)
	$GridContainer/BtnCarne.pressed.disconnect(_carne_callback)
	$GridContainer/BtnQueso.pressed.disconnect(_queso_callback)
	btn_volver.pressed.disconnect(_volver_callback)
