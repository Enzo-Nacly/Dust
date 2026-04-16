class_name Gravity_Component
extends Node2D

@export var forca_gravidade : float = 9.8
@export var raio_influencia : float = 6.0
@export var desenhar_circulo_influencia : bool = true

# duas constantes para não ter que escrever números grandes
const MULTIPLICADOR_RAIO_INFLUENCIA : float = 10**2
const MULTIPLICADOR_FORCA_GRAVIDADE : float = 10**2

var entidade : Node2D 

# apenas para ter certeza que existe uma entidade, um pai (parent)
func setup(_entidade : Node2D) -> void:
	entidade = _entidade

func pegar_gravidade_em(posicao_particula : Vector2) -> Vector2:
	
	# criando vetor que aponta da posição da particula para o centro do corpo celeste
	var vetor_centro : Vector2 = entidade.global_position - posicao_particula
	
	# pegando o módulo do vetor
	var distancia : float = vetor_centro.length()
	
	if distancia > raio_influencia * MULTIPLICADOR_RAIO_INFLUENCIA:
		return Vector2.ZERO
	
	# pega a direção para o centro e aplica a forca da gravidade
	var forca_gravitacional : Vector2 = vetor_centro.normalized() * forca_gravidade * MULTIPLICADOR_FORCA_GRAVIDADE
	return forca_gravitacional

# tem que sumir com esses magic numbers
func _draw() -> void:
	if desenhar_circulo_influencia:
		draw_arc(Vector2.ZERO, raio_influencia * MULTIPLICADOR_RAIO_INFLUENCIA, 0, TAU, 64, Color.RED, 2.0)
