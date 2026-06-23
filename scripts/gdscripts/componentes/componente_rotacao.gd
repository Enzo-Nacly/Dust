class_name ComponenteRotacao
extends Node2D

const AJUSTE_ORIENTACAO_SPRITE: float = PI / 2.0

var entidade: Node2D

#func _ready() -> void:
	## 'owner' já puxa direto a raiz da cena (o Player, o Planeta, etc.)
	#entidade = owner as Node2D

func setup(_entidade: Node2D) -> void:
	entidade = _entidade

func atualizar_rotacao(vetor_centro: Vector2) -> void:
	if entidade:
		entidade.rotation = vetor_centro.angle() - AJUSTE_ORIENTACAO_SPRITE
