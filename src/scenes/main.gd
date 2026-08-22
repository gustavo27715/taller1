extends Control

@onready var btn_simular: Button = $MainContainer/BtnSimular
@onready var btn_salir: Button = $MainContainer/BtnSalir

func _ready() -> void:
	btn_simular.pressed.connect(_on_simular_pressed)
	btn_salir.pressed.connect(_on_salir_pressed)

func _on_simular_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/level_1.tscn")

func _on_salir_pressed() -> void:
	get_tree().quit()
