class_name Planet
extends StaticBody2D

@onready var gravity_component : Gravity_Component = $Gravity_Component

func _ready() -> void:
	gravity_component.setup(self)

func pegar_gravidade_em(posicao_particula : Vector2) -> Vector2:
	return gravity_component.pegar_gravidade_em(posicao_particula)
