# res://src/core/main_app.gd
extends Node

@onready var scene_container: Control = $SceneContainer
var current_scene: Node = null

func _ready() -> void:
	print("MainApp: Inicializando...")
	EventBus.navigation_requested.connect(_on_navigation_requested)
	_on_navigation_requested("res://src/scenes/menu/menu_panel.tscn")

func _on_navigation_requested(target_scene_path: String) -> void:
	print("MainApp: Navegando a: ", target_scene_path)
	
	# Liberar escena anterior
	if current_scene:
		print("MainApp: Liberando escena anterior...")
		current_scene.queue_free()
		current_scene = null
		# Esperar un frame para que se libere correctamente
		await get_tree().process_frame
	
	# Cargar nueva escena
	var new_scene_resource = load(target_scene_path)
	
	if new_scene_resource:
		print("MainApp: Instanciando nueva escena...")
		current_scene = new_scene_resource.instantiate()
		scene_container.add_child(current_scene)
		print("MainApp: Escena cargada correctamente")
	else:
		printerr("MainApp: Error crítico - No se pudo cargar: ", target_scene_path)
