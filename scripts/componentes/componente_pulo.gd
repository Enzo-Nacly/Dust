class_name ComponentePulo
extends Node

@export var forca_pulo: int = 250
@onready var entidade: Node2D = self.owner
@onready var componente_gravidade: ComponenteGravidade = get_node("../ComponenteGravidade")

func pular() -> void:
	var vetor_centro: Vector2 = componente_gravidade.vetor_centro
	if entidade.is_on_floor():
		entidade.velocity -= vetor_centro * forca_pulo
