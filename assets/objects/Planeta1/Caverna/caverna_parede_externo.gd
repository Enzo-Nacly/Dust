extends StaticBody2D

@onready var caverna_puzzle: StaticBody2D = $"."
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D

func entry() ->void:
	sprite_2d.visible = false
	collision_polygon_2d.set_deferred("disabled", true)
func exit() -> void:
	sprite_2d.visible = true
	collision_polygon_2d.set_deferred("disabled", false)
