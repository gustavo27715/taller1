# res://src/data/food_data.gd
class_name FoodData
extends Resource

@export var id: String
@export var display_name: String
@export var emoji: String
@export var texture: Texture2D
@export var price: int
@export_group("Estadísticas")
@export var health: int
@export var speed: int
@export var jump: int
@export var energy: int
