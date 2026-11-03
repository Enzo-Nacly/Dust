class_name ComponenteAnimacao
extends Node

@export var debug_sprite_olhando: bool 
@export var sprite_olhando_esquerda: bool
@export var sprite: AnimatedSprite2D

@onready var entidade: CharacterBody2D = self.owner
#@onready var

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
