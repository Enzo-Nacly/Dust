extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D

func _ready() -> void:
	add_to_group("grupo_porta_da_caverna0") 

func abrir() -> void:
	sprite_2d.visible = false
	collision_polygon_2d.set_deferred("disabled", true)
