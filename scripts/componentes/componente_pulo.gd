class_name ComponentePulo
extends Node2D

@export var forca_pulo: float = 400.0
@onready var entidade: Node2D = self.owner

func pular(vetor_centro: Vector2) -> void:
	var quis_pular: bool = Input.is_action_just_pressed("ui_accept")
	var esta_no_chao: bool = entidade.is_on_floor()

	if quis_pular and esta_no_chao:
		entidade.velocity -= vetor_centro * forca_pulo
