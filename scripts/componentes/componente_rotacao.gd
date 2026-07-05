class_name ComponenteRotacao
extends Node

@onready var entidade: CharacterBody2D = self.owner
@onready var componente_gravidade: ComponenteGravidade = get_node("../ComponenteGravidade")
const AJUSTE_ORIENTACAO_SPRITE: float = PI / 2.0


func atualizar_rotacao() -> void:
	var vetor_centro: Vector2 = componente_gravidade.vetor_centro
	entidade.rotation = vetor_centro.angle() - AJUSTE_ORIENTACAO_SPRITE
