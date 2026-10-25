extends StaticBody2D

@onready var colisao: CollisionShape2D = $"../CollisionShape2D"

var aberto := false

func _ready() -> void:
	add_to_group("grupo_porta_da_caverna0")
	colisao.set_deferred("disabled", true)  # começa desativada

func abrir() -> void:
	if aberto:
		return
	aberto = true

	var tween = create_tween()
	for sprite in get_children():
		tween.tween_property(sprite, "position:y", 200, 3.0)

	colisao.set_deferred("disabled", false)  # ativa só quando abrir
