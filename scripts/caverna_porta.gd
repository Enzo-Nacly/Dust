extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var entrar_esair: Area2D = $"../ComponentEntryExit"

func _ready() -> void:
	add_to_group("grupo_porta_da_caverna0") 
	entrar_esair.get_node("CollisionShape2D").set_deferred("disabled", true)

func abrir() -> void:
	var tween = create_tween()
	tween.tween_property(sprite_2d, "self_modulate:a", 0.0, 0.5)
	entrar_esair.get_node("CollisionShape2D").set_deferred("disabled", false)
