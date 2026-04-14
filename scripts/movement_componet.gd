class_name MovementComponent
extends Node

@export var velocidade : float = 5.0

const VELOCIDADE_ANGULAR : float = 1.0/30.0
const MULTIPLICADOR_VELOCIDADE : float = 10**2

var entidade : CharacterBody2D 

# apenas para ter certeza que existe uma entidade, um pai (parent)
func setup(_entidade : Node2D) -> void:
	entidade = _entidade
	
func mover() -> void:
	var direcao : float = Input.get_axis("ui_left", "ui_right") 
	
	if entidade.motion_mode == CharacterBody2D.MOTION_MODE_GROUNDED:
		var incremento_velocidade : float = direcao * velocidade * MULTIPLICADOR_VELOCIDADE
		
		var vetor_lateral : float = entidade.velocity.dot(entidade.transform.x)
		
		entidade.velocity -= entidade.transform.x * vetor_lateral
		
		entidade.velocity += entidade.transform.x * incremento_velocidade
	
	else:
		entidade.rotate(VELOCIDADE_ANGULAR * direcao)
	
