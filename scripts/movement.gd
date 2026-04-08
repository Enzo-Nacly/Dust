class_name MovementComponent
extends Node

@export var speed : float
const SPEED_MULTIPLIER : float = 10**3

var entity : CharacterBody2D

func setup(_entity : CharacterBody2D) -> void:
	entity = _entity
	print(SPEED_MULTIPLIER)
	
func run(_delta : float) -> void:
	# variável input pode ser -1, 0 ou 1
	var input : float = Input.get_axis("ui_left", "ui_right") 
	var velocity_incresement : float = input * speed * SPEED_MULTIPLIER
	
	# usa-se tranform.x pois é em relação a horizontal do personagem
	# e este é um movimento com aceleração
	#entity.velocity += entity.transform.x * input * speed * delta
	
	var vetor_lateral : float = entity.velocity.dot(entity.transform.x)
	
	entity.velocity -= entity.transform.x * vetor_lateral
	
	entity.velocity += entity.transform.x * velocity_incresement
	
