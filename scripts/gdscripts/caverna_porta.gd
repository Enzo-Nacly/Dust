extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D

func _ready() -> void:
	add_to_group("grupo_porta_da_caverna0") 

func abrir() -> void:
	var tween = create_tween()
	tween.tween_property(sprite_2d, "self_modulate:a", 0.0, 0.5)
	collision_polygon_2d.set_deferred("disabled", true)
