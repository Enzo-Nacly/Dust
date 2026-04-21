class_name MovementComponent
extends Node

@export var velocidade : float = 5.0

const VELOCIDADE_ANGULAR : float = 1.0/30.0
const MULTIPLICADOR_VELOCIDADE : float = 10**2
const INTENSIDADE_ATRITO : float = 500.0

var entidade : CharacterBody2D 

# apenas para ter certeza que existe uma entidade, um pai (parent)
func setup(_entidade : Node2D) -> void:
	entidade = _entidade
	
func mover(delta : float) -> void:
	var direcao : float = Input.get_axis("ui_left", "ui_right") 
	
	if entidade.motion_mode != CharacterBody2D.MOTION_MODE_GROUNDED:
		entidade.rotate(VELOCIDADE_ANGULAR * direcao)
		return
		
	if direcao != 0.0:
		aplicar_movimento(direcao)
		
	if entidade.is_on_floor():
		aplicar_atrito(delta)
	
	
func aplicar_movimento(direcao : float) -> void:
	var incremento_velocidade : float = direcao * velocidade * MULTIPLICADOR_VELOCIDADE
	var nova_velocidade_lateral : Vector2 = entidade.transform.x * incremento_velocidade

	var modulo_velocidade_lateral : float = entidade.velocity.dot(entidade.transform.x)
	var velocidade_lateral : Vector2 = entidade.transform.x * modulo_velocidade_lateral

	entidade.velocity -= velocidade_lateral
	entidade.velocity += nova_velocidade_lateral
	
	
func aplicar_atrito(delta : float) -> void:
	var modulo_velocidade_lateral : float = entidade.velocity.dot(entidade.transform.x)
	var velocidade_lateral : Vector2 = entidade.transform.x * modulo_velocidade_lateral
	
	var modulo_velocidade_lateral_atritada : float = move_toward(modulo_velocidade_lateral, 0, INTENSIDADE_ATRITO * delta)
	var velocidade_lateral_atritada : Vector2 = entidade.transform.x * modulo_velocidade_lateral_atritada
	
	entidade.velocity -= velocidade_lateral
	entidade.velocity += velocidade_lateral_atritada
