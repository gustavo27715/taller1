extends Control

@onready var status_label: Label = $GridContainer/StatusLabel
@onready var btn_volver: Button = $GridContainer/BtnVolver

func _ready() -> void:
	$GridContainer/BtnTomate.pressed.connect(_on_ingrediente_selected.bind("Tomate", 5))
	$GridContainer/BtnLechuga.pressed.connect(_on_ingrediente_selected.bind("Lechuga", 3))
	$GridContainer/BtnCarne.pressed.connect(_on_ingrediente_selected.bind("Carne", 10))
	$GridContainer/BtnQueso.pressed.connect(_on_ingrediente_selected.bind("Queso", 8))
	
	btn_volver.pressed.connect(_on_volver_pressed)

func _on_ingrediente_selected(nombre: String, costo: int) -> void:
	status_label.text = "Selección: %s (+$%d)" % [nombre, costo]
	print("Seleccionaste: %s - Costo: $%d" % [nombre, costo])

func _on_volver_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/main.tscn")
