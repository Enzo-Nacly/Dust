class_name ComponentePulo
extends Node

@export var forca_pulo: int = 250
@onready var entidade: Node2D = self.owner
@onready var componente_gravidade: ComponenteGravidade = get_node("../ComponenteGravidade")

func pular() -> void:
	var quis_pular: bool = Input.is_action_just_pressed("ui_accept")
	var esta_no_chao: bool = entidade.is_on_floor()
	
	var vetor_centro: Vector2 = componente_gravidade.vetor_centro
	if quis_pular and esta_no_chao:
		entidade.velocity -= vetor_centro * forca_pulo
