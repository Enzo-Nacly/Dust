class_name MovementComponent
extends Node

@export var speed : float
var angular_speed : float = 1.0/30.0
const SPEED_MULTIPLIER : float = 10**2

var entity : CharacterBody2D

# just to make sure the entity exists
func setup(_entity : CharacterBody2D) -> void:
	entity = _entity
	
func move(_delta : float) -> void:
	var input : float = Input.get_axis("ui_left", "ui_right") 
	if entity.motion_mode == CharacterBody2D.MOTION_MODE_GROUNDED:
		# variável input pode ser -1, 0 ou 1
		#var input : float = Input.get_axis("ui_left", "ui_right") 
		var velocity_incresement : float = input * speed * SPEED_MULTIPLIER
		
		# usa-se tranform.x pois é em relação a horizontal do personagem
		# e este é um movimento com aceleração
		#entity.velocity += entity.transform.x * input * speed * delta
		
		var vetor_lateral : float = entity.velocity.dot(entity.transform.x)
		
		entity.velocity -= entity.transform.x * vetor_lateral
		
		entity.velocity += entity.transform.x * velocity_incresement
	
	else:
		entity.rotate(angular_speed * input)
	
