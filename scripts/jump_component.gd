class_name Jump_Component
extends Node2D

@export var forca_pulo : float = 400.0

var entidade : CharacterBody2D 

# apenas para ter certeza que existe uma entidade, um pai (parent)
func setup(_entidade : Node2D) -> void:
	entidade = _entidade

func pular(vetor_centro : Vector2) -> void:
	var quis_pular : float = Input.is_action_just_pressed("ui_accept")
	var esta_no_chao : bool = entidade.is_on_floor()
	
	if quis_pular and esta_no_chao:
		entidade.velocity -= vetor_centro * forca_pulo
