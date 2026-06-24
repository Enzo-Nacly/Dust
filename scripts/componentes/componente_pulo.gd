class_name ComponentePulo
extends Node2D

@export var forca_pulo: float = 400.0

var entidade: CharacterBody2D

#func _ready() -> void:
	## 'owner' já puxa direto a raiz da cena (o Player, o Planeta, etc.)
	#entidade = owner as Node2D

func setup(_entidade: Node2D) -> void:
	entidade = _entidade as CharacterBody2D

func pular(vetor_centro: Vector2) -> void:
	var quis_pular: bool = Input.is_action_just_pressed("ui_accept")
	var esta_no_chao: bool = entidade.is_on_floor()

	if quis_pular and esta_no_chao:
		entidade.velocity -= vetor_centro * forca_pulo
