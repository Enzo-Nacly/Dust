class_name ComponenteGravidade
extends Node

@onready var entidade: CharacterBody2D = self.owner

var corpo_celeste: Planeta
var vetor_centro: Vector2
var esta_em_campo: bool


func _ready() -> void:
	var corpo_celestes = get_tree().get_nodes_in_group("planets")
	if corpo_celestes.size() > 0:
		corpo_celeste = corpo_celestes[0] as Planeta

func aplicar_gravidade(delta: float) -> void:
	var forca_gravitacional: Vector2 = pegar_forca_gravitacional()
	entidade.velocity += forca_gravitacional * delta

func pegar_forca_gravitacional() -> Vector2:
	var forca_gravitacional: Vector2 = corpo_celeste.pegar_gravidade_em(entidade.global_position)
	_esta_em_campo(forca_gravitacional)
	_registrar_vetor_centro(forca_gravitacional)
	
	return forca_gravitacional

func _esta_em_campo(forca_gravitacional: Vector2) -> void:
	if forca_gravitacional == Vector2.ZERO: esta_em_campo = false
	else: esta_em_campo = true

func _registrar_vetor_centro(forca_gravitacional: Vector2) -> void:
	self.vetor_centro = forca_gravitacional.normalized()
