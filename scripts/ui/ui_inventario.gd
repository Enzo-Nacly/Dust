class_name UIInventario
extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var velocidade_aparecimento: float = 1.0
var velocidade_desaparecimento: float = 0.5
var duracao_animacao: float = 0.0
var progresso_animacao: float = 0.0
var aberto: bool = false

var slots: Array[Panel]
var index_antigo_slot_selecionado: int = 1

func _ready() -> void:
	fechar()
	for slot in $VBoxContainer.get_children():
		slots.append(slot)
		
	duracao_animacao = animation_player.get_animation("desaparecer").length
	
	selecionar_slot(index_antigo_slot_selecionado)

func _process(delta: float) -> void:
	_processar_animacao(delta)

func adicionar_textura_slot(index_slot: int, textura: Texture2D) -> void:
	if index_slot >= 0 and index_slot < slots.size():
		var textura_slot: TextureRect = slots[index_slot].get_child(0)
		textura_slot.texture = textura

func _processar_animacao(delta: float) -> void:
	if aberto:
		self.visible = true
		progresso_animacao += velocidade_aparecimento * delta
	else: 
		if progresso_animacao == duracao_animacao: 
			self.visible = false
			return
		progresso_animacao -= velocidade_desaparecimento * delta
	
	progresso_animacao = clamp(progresso_animacao, 0.0, duracao_animacao)
	
	#if progresso_animacao == duracao_animacao: fechar()
	#elif progresso_animacao == 0.0: abrir()
	
	animation_player.seek(progresso_animacao, true)

func selecionar_slot(index_slot: int) -> void:
	if !(index_slot >= 0 and index_slot < slots.size()):
		return
	var slot_antigo_selecionado = slots[index_antigo_slot_selecionado]
	var slot_selecionado: Panel = slots[index_slot]
	
	var style_desselecionado = slot_selecionado.get_theme_stylebox("panel").duplicate() as StyleBoxFlat
	style_desselecionado.border_color = Color.WHITE
	slot_antigo_selecionado.add_theme_stylebox_override("panel", style_desselecionado)
	
	var style_selecionado = slot_selecionado.get_theme_stylebox("panel").duplicate() as StyleBoxFlat
	style_selecionado.border_color = Color.RED
	slot_selecionado.add_theme_stylebox_override("panel", style_selecionado)
	index_antigo_slot_selecionado = index_slot

func abrir() -> void:
	aberto = true

func fechar() -> void:
	aberto = false
