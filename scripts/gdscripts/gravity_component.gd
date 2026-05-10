class_name Gravity_Component
extends Node2D

@export var desenhar_circulo_influencia : bool = true

const MULTIPLICADOR_RAIO : float = 3.0

var entidade : Node2D 
var forca_gravidade : int
var raio_influencia : float

# apenas para ter certeza que existe uma entidade, um pai (parent)
func setup(_entidade : Node2D, raio : int) -> void:
	entidade = _entidade
	raio_influencia = raio * MULTIPLICADOR_RAIO
	forca_gravidade = calcular_forca_gravidade(raio)
	

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
	
	
func log_base(numero: float, base: float) -> float:
	return log(numero) / log(base)
	
	
func calcular_forca_gravidade(raio: float) -> int:
	const BASE : float = 2.5
	var forca_g := log_base(raio, BASE) * 10**2
	return roundi(forca_g)
	
	
func _draw() -> void:
	if desenhar_circulo_influencia:
		var centro_circulo : Vector2 = Vector2.ZERO
		var segmentos_arco : int = int((raio_influencia/MULTIPLICADOR_RAIO)/4)
		var grossura_arco : float = 2.0
		draw_arc(centro_circulo, raio_influencia, 0, TAU, segmentos_arco, Color.RED, grossura_arco)
