class_name ComponenteInventario
extends Node

@export var inventario: Inventario
@export var ui_inventario: UIInventario

var index_slot_selecionado: int = 0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("cima_inventario") or Input.is_action_just_pressed("baixo_inventario"):
		ui_inventario.abrir()
	else: ui_inventario.fechar()
	
	if Input.is_action_just_pressed("cima_inventario"):
		index_slot_selecionado -= 1
	elif Input.is_action_just_pressed("baixo_inventario"):
		index_slot_selecionado += 1
	
	if index_slot_selecionado > 2: index_slot_selecionado = 0
	elif index_slot_selecionado < 0: index_slot_selecionado = 2
	ui_inventario.selecionar_slot(index_slot_selecionado)
