class_name Porta
extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var entrar_sair: Area2D = $"../ComponentEntryExit"

func _ready() -> void:
	add_to_group("grupo_porta_da_caverna0") 
	entrar_sair.get_node("CollisionPolygon2D").set_deferred("disabled", true)

func abrir() -> void:
	var tween = create_tween()
	
	var distancia_descida = sprite_2d.texture.get_size().y 
	tween.tween_property(sprite_2d, "position:y", distancia_descida, 1)
	tween.tween_property(sprite_2d, "self_modulate:a", 0.0, 0.2)
	
	entrar_sair.get_node("CollisionPolygon2D").set_deferred("disabled", false)
