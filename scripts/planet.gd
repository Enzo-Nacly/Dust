class_name Planet
extends StaticBody2D

@export var cor : Color = Color.RED
@onready var gravity_component : Gravity_Component = $Gravity_Component
@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	gravity_component.setup(self)

func pegar_gravidade_em(posicao_particula : Vector2) -> Vector2:
	return gravity_component.pegar_gravidade_em(posicao_particula)

func _draw():
	var shape : Shape2D = collision_shape.shape

	if shape is CircleShape2D:
		var raio : float = shape.radius
		var posicao_centro : Vector2 = Vector2.ZERO
		draw_circle(posicao_centro, raio, cor)
