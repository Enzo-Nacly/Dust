class_name Rotation_Component
extends Node2D

var entidade : Node2D 

# apenas para ter certeza que existe uma entidade, um pai (parent)
func setup(_entidade : Node2D) -> void:
	entidade = _entidade
	
# rotacionando a entidade para ficar perendicular ao centro
func atualizar_rotacao(vetor_centro : Vector2) -> void:
	const AJUSTE_ORIENTACAO_SPRITE : float = PI/2
	entidade.rotation = vetor_centro.angle() - AJUSTE_ORIENTACAO_SPRITE
