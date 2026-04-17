class_name Gravity_Component
extends Node2D

@export var desenhar_circulo_influencia : bool = true

# duas constantes para não ter que escrever números grandes
#const MULTIPLICADOR_FORCA_GRAVIDADE : float = 1.0/100.0
const MULTIPLICADOR_FORCA_GRAVIDADE : float = 100
const SOMADOR_RAIO : float = 500.0

var entidade : Node2D 
var forca_gravidade : float
var raio_influencia : float

# apenas para ter certeza que existe uma entidade, um pai (parent)
func setup(_entidade : Node2D, _forca_gravidade : float, raio : float) -> void:
	entidade = _entidade
	#forca_gravidade = raio * MULTIPLICADOR_FORCA_GRAVIDADE
	forca_gravidade = _forca_gravidade * MULTIPLICADOR_FORCA_GRAVIDADE
	raio_influencia = raio + SOMADOR_RAIO
	print(forca_gravidade)

func pegar_gravidade_em(posicao_particula : Vector2) -> Vector2:
	
	# criando vetor que aponta da posição da particula para o centro do corpo celeste
	var vetor_centro : Vector2 = entidade.global_position - posicao_particula
	
	# pegando o módulo do vetor
	var distancia : float = vetor_centro.length()
	
	if distancia > raio_influencia:
		return Vector2.ZERO
	
	# pega a direção para o centro e aplica a forca da gravidade
	var forca_gravitacional : Vector2 = vetor_centro.normalized() * forca_gravidade
	return forca_gravitacional

func _draw() -> void:
	if desenhar_circulo_influencia:
		var centro_circulo : Vector2 = Vector2.ZERO
		var segmentos_arco : int = 64
		var grossura_arco : float = 2.0
		draw_arc(centro_circulo, raio_influencia, 0, TAU, segmentos_arco, Color.RED, grossura_arco)
