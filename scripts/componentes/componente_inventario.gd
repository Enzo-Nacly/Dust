class_name GerenciadorInventario
extends Node

const TEMPO_TOTAL_ESPERA: float = 1.0

@export var inventario: Inventario
@export var ui_inventario: UIInventario

var index_slot_selecionado: int = 0
var tempo_espera: float = TEMPO_TOTAL_ESPERA

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	_fade_in_out(delta)
	_selecionar_slot()

func _fade_in_out(delta: float) -> void:
	if Input.is_action_just_pressed("cima_inventario") or Input.is_action_just_pressed("baixo_inventario"):
		ui_inventario.aparecendo = true
		tempo_espera = TEMPO_TOTAL_ESPERA
	
	elif tempo_espera != 0.0:
		tempo_espera -= delta
		tempo_espera = max(tempo_espera, 0.0)
	
	elif tempo_espera == 0.0:
		ui_inventario.aparecendo = false
		ui_inventario.desaparecendo = true

func _selecionar_slot() -> void:
	if Input.is_action_just_pressed("cima_inventario"):
		index_slot_selecionado -= 1
	elif Input.is_action_just_pressed("baixo_inventario"):
		index_slot_selecionado += 1
	
	if index_slot_selecionado > 2: index_slot_selecionado = 0
	elif index_slot_selecionado < 0: index_slot_selecionado = 2
	ui_inventario.selecionar_slot(index_slot_selecionado)
