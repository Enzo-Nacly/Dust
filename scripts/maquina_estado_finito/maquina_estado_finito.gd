class_name MaquinaEstadoFinito
extends Node

@export var mostrar_estados: bool = false
@export var estado_inicial: Estado

var estados: Dictionary = {}
var estado_atual: Estado

func _ready() -> void:
	for filho: Estado in get_children():
		estados[filho.name.to_lower()] = filho
		filho.transicionar_estado.connect(mudar_estado)
	
	var estado_inicial_nome = estado_inicial.name.to_lower()
	if estados.has(estado_inicial_nome):
		estados[estado_inicial_nome].entrar()
		estado_atual = estado_inicial
		
		if mostrar_estados: print(estado_atual.name.to_lower(), "\n")

func _process(_delta: float) -> void:
	if estado_atual:
		estado_atual.atualizar()

func _physics_process(delta: float) -> void:
	if estado_atual:
		estado_atual.atualizar_fisica(delta)

func mudar_estado(emissor: Estado, novo_estado_nome: Estado) -> void:
	if emissor != estado_atual: return
	
	var novo_estado: Estado = estados.get(novo_estado_nome.name.to_lower())
	if !novo_estado: return
	
	if estado_atual: estado_atual.sair()
	
	novo_estado.entrar()
	estado_atual = novo_estado
	
	if mostrar_estados: print(estado_atual.name.to_lower(), "\n")

func pegar_direcao() -> float:
	return estado_atual.pegar_direcao()

func quer_pular() -> float:
	return estado_atual.quer_pular()
