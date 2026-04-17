class_name Planet
extends StaticBody2D

@export var planet_resource : Planet_Resource

@onready var gravity_component : Gravity_Component = $Gravity_Component
@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	gravity_component.setup(self, planet_resource.forca_gravidade, planet_resource.raio)
	
	var shape : Shape2D = collision_shape.shape
	if shape is CircleShape2D:
		shape.radius = planet_resource.raio
	

func pegar_gravidade_em(posicao_particula : Vector2) -> Vector2:
	return gravity_component.pegar_gravidade_em(posicao_particula)

func _draw():
	var posicao_centro : Vector2 = Vector2.ZERO
	draw_circle(posicao_centro, planet_resource.raio, planet_resource.cor)
