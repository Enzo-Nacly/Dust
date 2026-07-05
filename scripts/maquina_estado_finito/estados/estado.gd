class_name Estado
extends Node

signal transicionar_estado(estado: Estado)

func entrar() -> void:
	pass

func atualizar() -> void:
	pass

func atualizar_fisica(delta: float) -> void:
	pass

func sair() -> void:
	pass

func pegar_direcao() -> float:
	return 0.0

func quer_pular() -> bool:
	return false
