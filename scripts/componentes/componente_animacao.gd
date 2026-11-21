class_name ComponenteAnimacao
extends Node

@export var index_sprite_pe_chao: Array[int]
@export var tem_componente_sonoro: bool = true
@export var debug_sprite_olhando: bool 
@export var sprite_olhando_esquerda: bool
@export var sprite: AnimatedSprite2D

@onready var entidade: CharacterBody2D = self.owner

var componente_sonoro: ComponenteSonoro

func _ready() -> void:
	if not tem_componente_sonoro: return
	
	componente_sonoro = get_node("../ComponenteSonoro")
	
	sprite.frame_changed.connect(_on_sprite_frame_changed)

func mudar_direcao_sprite(direcao: int) -> void:
	if direcao == 0: 
		return
	
	# Aplica o flip_h comparando se o lado original da arte é diferente da direção do movimento
	sprite.flip_h = (sprite_olhando_esquerda != (direcao < 0))
	
	if debug_sprite_olhando:
		print("sprite: ", "esquerda" if direcao < 0 else "direita")

func animar(direcao: int) -> void:
	if entidade.is_on_floor():
		if direcao == 0: sprite.play("idle")
		elif direcao == 1 or direcao == -1: sprite.play("andando")
	else:
		sprite.play("idle")

func _on_sprite_frame_changed() -> void:
	if not tem_componente_sonoro or not componente_sonoro: return
	if len(index_sprite_pe_chao) == 0: return
	
	if sprite.animation == "andando" and sprite.frame in index_sprite_pe_chao:
		componente_sonoro.tocar_sfx()
	
