class_name ComponenteRotacao
extends Node2D

@onready var entidade: CharacterBody2D = self.owner
const AJUSTE_ORIENTACAO_SPRITE: float = PI / 2.0


func atualizar_rotacao(vetor_centro: Vector2) -> void:
	if entidade:
		entidade.rotation = vetor_centro.angle() - AJUSTE_ORIENTACAO_SPRITE
