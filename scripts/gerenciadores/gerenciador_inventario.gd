extends Node

const TEMPO_TOTAL_ESPERA: float = 1.0

var index_slot_selecionado: int = 0
var tempo_espera: float = TEMPO_TOTAL_ESPERA

var inventario: Inventario
var ui_inventario: UIInventario

func _process(delta: float) -> void:
	if not ui_inventario: return
	
	_temporazicao_visualizao(delta)
	_selecionar_slot()

func _temporazicao_visualizao(delta: float) -> void:
	if (Input.is_action_just_pressed("cima_inventario") or Input.is_action_just_pressed("baixo_inventario")) and Game_Manager.can_move:
		ui_inventario.aparecendo = true
		tempo_espera = TEMPO_TOTAL_ESPERA
		print("mostra")
	
	elif tempo_espera != 0.0:
		tempo_espera -= delta
		tempo_espera = max(tempo_espera, 0.0)
	
	elif tempo_espera == 0.0:
		ui_inventario.aparecendo = false
		ui_inventario.desaparecendo = true

func _selecionar_slot() -> void:
	if not Game_Manager.can_move: return
	
	if Input.is_action_just_pressed("cima_inventario"):
		index_slot_selecionado -= 1
	elif Input.is_action_just_pressed("baixo_inventario"):
		index_slot_selecionado += 1
	
	if index_slot_selecionado > ui_inventario.slots.size(): index_slot_selecionado = 0
	elif index_slot_selecionado < 0: index_slot_selecionado = ui_inventario.slots.size()
	ui_inventario._selecionar_slot(index_slot_selecionado)
