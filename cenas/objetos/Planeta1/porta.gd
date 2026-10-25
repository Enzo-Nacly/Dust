class_name Porta
extends StaticBody2D

@onready var colisao: Node = _achar_colisao_irma()

func _achar_colisao_irma() -> Node:
	for irmao in get_parent().get_children():
		if irmao is CollisionShape2D or irmao is CollisionPolygon2D:
			return irmao
	return null
	
	
var aberto = false
var shape_retangulo = RectangleShape2D.new()



func _ready() -> void:
	add_to_group("grupo_porta_da_caverna0")
	colisao.set_deferred("disabled", true) 
	if aberto == false:
		colisao.disabled = true



func abrir() -> void:
	if aberto:
		return
	aberto = true
	shape_retangulo.size = Vector2(37, 57.5)
	colisao.shape = shape_retangulo
	var tween = create_tween()
	for sprite in get_children():
		tween.tween_property(sprite, "position:y", 200, 3.0)

	colisao.set_deferred("disabled", false)
