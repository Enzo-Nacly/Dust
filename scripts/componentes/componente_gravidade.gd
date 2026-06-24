class_name ComponenteGravidade
extends Node2D

@export var desenhar_circulo_influencia: bool = true

const MULTIPLICADOR_RAIO: float = 3.0

var entidade: Node2D
var forca_gravidade: int
var raio_influencia: float

#func _ready() -> void:
	## 'owner' já puxa direto a raiz da cena (o Player, o Planeta, etc.)
	#entidade = owner as Node2D

func setup(_entidade: Node2D, raio: int) -> void:
	entidade = _entidade
	raio_influencia = MULTIPLICADOR_RAIO * raio
	forca_gravidade = _calcular_forca_gravidade(raio)
	queue_redraw()

func _log_base(numero: float, base_log: float) -> float:
	return log(numero) / log(base_log)

func _calcular_forca_gravidade(raio: float) -> int:
	const BASE_LOG: float = 2.5
	var forca_g: float = _log_base(raio, BASE_LOG) * pow(10, 2)
	return int(forca_g)

func pegar_gravidade_em(posicao_particula: Vector2) -> Vector2:
	var vetor_centro: Vector2 = entidade.global_position - posicao_particula
	var distancia: float = vetor_centro.length()
	
	if distancia > raio_influencia:
		return Vector2.ZERO

	var forca_gravitacional: Vector2 = vetor_centro.normalized() * forca_gravidade
	return forca_gravitacional

func _draw() -> void:
	if desenhar_circulo_influencia:
		var centro_circulo: Vector2 = Vector2.ZERO
		var segmentos_arco: int = int((raio_influencia / MULTIPLICADOR_RAIO) / 4)
		var grossura_arco: float = 2.0
		draw_arc(centro_circulo, raio_influencia, 0, TAU, segmentos_arco, Color.RED, grossura_arco)
