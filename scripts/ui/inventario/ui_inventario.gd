class_name UIInventario
extends Control

const SLOT_INVENTARIO_PRELOAD: PackedScene = preload("res://cenas/ui/inventario/slot_inventario.tscn")

@export var debug: bool = false

@export var cor_slot_selecionado: Color = Color(0, 0, 0, 0.3)
@export var cor_slot_desselecionado: Color = Color(0, 0, 0, 0.1)

@onready var animation_player: AnimationPlayer = $AnimationPlayer
#@onready var recipiente_slots: VBoxContainer = $CenterContainer/VBoxContainer

var velocidade_aparecimento: float = 5.0
var velocidade_desaparecimento: float = 1.0
var duracao_animacao: float = 0.0
var progresso_animacao: float = 0.0

var visivel: bool = false
var aparecendo: bool = false
var desaparecendo: bool = true

var inventario: Inventario
var slots: Array[SlotInventario]
var index_antigo_slot_selecionado: int = 0

func _ready() -> void:
	self.visible = visivel
	duracao_animacao = animation_player.get_animation("aparecendo").length
	
	_setar()

func _process(delta: float) -> void:
	self.visible = visivel
	_fade_in_out(delta)

func _fade_in_out(delta: float) -> void:
	if aparecendo:
		visivel = true
		progresso_animacao += velocidade_aparecimento * delta

	if desaparecendo:
		progresso_animacao -= velocidade_desaparecimento * delta
	
	progresso_animacao = clamp(progresso_animacao, 0.0, duracao_animacao)
	animation_player.seek(progresso_animacao, true)
	if progresso_animacao == 0.0: visivel = false

func _selecionar_slot(index_slot: int) -> void:
	if !(index_slot >= 0 and index_slot < slots.size()):
		return
	var slot_antigo_selecionado: Panel = slots[index_antigo_slot_selecionado]
	var slot_selecionado: Panel = slots[index_slot]
	
	_setar_cor_slot(slot_antigo_selecionado, cor_slot_desselecionado)
	_setar_cor_slot(slot_selecionado, cor_slot_selecionado)
	
	index_antigo_slot_selecionado = index_slot

func _setar_cor_slot(slot: Panel, cor: Color) -> void:
	var style = slot.get_theme_stylebox("panel").duplicate() as StyleBoxFlat
	style.bg_color = cor
	style.border_color = cor
	slot.add_theme_stylebox_override("panel", style)

func _setar() -> void:
	await get_tree().process_frame
	
	GerenciadorInventario.ui_inventario = self
	inventario = GerenciadorInventario.inventario
	
	_criar_slots()
	_preencher_slots()
	
	if not slots.is_empty():
		index_antigo_slot_selecionado = 0
		_selecionar_slot(0)

func _criar_slots() -> void:
	for slot in slots:
		slot.queue_free()
	slots.clear()
	
	if inventario == null: return
	
	for i in inventario.itens.size():
		var slot: SlotInventario = SLOT_INVENTARIO_PRELOAD.instantiate()
		
		#recipiente_slots.add_child(slot)
		$VBoxContainer.add_child(slot)
		slots.append(slot)

func _preencher_slots() -> void:
	if inventario == null: return
	
	for i in inventario.itens.size():
		slots[i].definir_textura(inventario.itens[i])
