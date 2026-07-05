class_name ComponenteMovimento
extends Node  

@export var proporcao_velocidade: float = 3.0
@onready var entidade: CharacterBody2D = self.owner

const MULTIPLICADOR_VELOCIDADE: float = 100.0
const VELOCIDADE_ANGULAR: float = 1.0 / 30.0
const ATRITO: float = 500.0
const ACELERACAO: float = 500.0

func mover(delta: float, direcao: float) -> void:
	if entidade.motion_mode == CharacterBody2D.MOTION_MODE_FLOATING:
		entidade.rotate(VELOCIDADE_ANGULAR * direcao)
		return

	if direcao != 0.0:
		_aplicar_aceleracao(delta, direcao)
	elif entidade.is_on_floor():
		var modulo_velocidade_lateral: float = entidade.velocity.dot(entidade.transform.x)
		if modulo_velocidade_lateral != 0.0:
			_aplicar_atrito(delta)

func _aplicar_aceleracao(delta: float, direcao: float) -> void:
	var modulo_velocidade_lateral: float = entidade.velocity.dot(entidade.transform.x)
	var velocidade_lateral: Vector2 = entidade.transform.x * modulo_velocidade_lateral

	var modulo_velocidade: float = direcao * proporcao_velocidade * MULTIPLICADOR_VELOCIDADE
	var modulo_velocidade_lateral_acelerada: float = move_toward(modulo_velocidade_lateral, modulo_velocidade, ACELERACAO * delta)
	var velocidade_lateral_acelerada: Vector2 = entidade.transform.x * modulo_velocidade_lateral_acelerada

	entidade.velocity -= velocidade_lateral
	entidade.velocity += velocidade_lateral_acelerada

func _aplicar_atrito(delta: float) -> void:
	var modulo_velocidade_lateral: float = entidade.velocity.dot(entidade.transform.x)
	var velocidade_lateral: Vector2 = entidade.transform.x * modulo_velocidade_lateral

	var modulo_velocidade_lateral_atritada: float = move_toward(modulo_velocidade_lateral, 0.0, ATRITO * delta)
	var velocidade_lateral_atritada: Vector2 = entidade.transform.x * modulo_velocidade_lateral_atritada

	entidade.velocity -= velocidade_lateral
	entidade.velocity += velocidade_lateral_atritada
