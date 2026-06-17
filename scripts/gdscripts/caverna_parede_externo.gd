extends StaticBody2D

@onready var caverna_puzzle: StaticBody2D = $"."
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D



func entry() ->void:
	var tween = create_tween()
	tween.tween_property(sprite_2d, "self_modulate:a", 0.0, 0.3)

	collision_polygon_2d.set_deferred("disabled", true)
func exit() -> void:
	var tween = create_tween()
	tween.tween_property(sprite_2d, "self_modulate:a", 1.0, 0.3)
	collision_polygon_2d.set_deferred("disabled", false)
