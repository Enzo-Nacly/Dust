class_name ComponenteInventario
extends Node

const TEMPO_TOTAL_ESPERA: float = 2.0

@export var inventario: Inventario
@export var ui_inventario: UIInventario

var index_slot_selecionado: int = 0
var tempo_espera: float = TEMPO_TOTAL_ESPERA

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("cima_inventario") or Input.is_action_just_pressed("baixo_inventario"):
		tempo_espera = TEMPO_TOTAL_ESPERA
		return
	
	else:
		tempo_espera -= delta
		tempo_espera = max(tempo_espera, 0.0)
	
	#if ui_inventario.visivel and ui_inventario.fechando and tempo_espera > 0.0:
		#tempo_espera -= delta
		#tempo_espera = max(tempo_espera, 0.0)
	
	if tempo_espera == 0.0:
		pass
	
	print(tempo_espera)
	
	if Input.is_action_just_pressed("cima_inventario"):
		index_slot_selecionado -= 1
	elif Input.is_action_just_pressed("baixo_inventario"):
		index_slot_selecionado += 1
	
	if index_slot_selecionado > 2: index_slot_selecionado = 0
	elif index_slot_selecionado < 0: index_slot_selecionado = 2
	ui_inventario.selecionar_slot(index_slot_selecionado)
