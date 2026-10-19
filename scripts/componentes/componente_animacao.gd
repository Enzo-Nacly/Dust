class_name ComponenteAnimacao
extends Node

#@export var animation_player: AnimationPlayer
#@export var sprite: Sprite2D
@export var sprite: AnimatedSprite2D

@onready var entidade: CharacterBody2D = self.owner
#@onready var

func animar(direcao: int) -> void:
	if entidade.is_on_floor():
		if direcao == 0: sprite.play("idle")
		elif direcao == 1 or direcao == -1: sprite.play("andando")
	else:
		sprite.play("idle")
