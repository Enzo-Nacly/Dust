class_name Cristal
extends Node2D

signal cor_alterada(cor: Color)

@export var cores: Array[Color] = []

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var cristal_sprite: Sprite2D = $Sprites/cristal_sprite
@onready var manivela_sprite: Sprite2D = $Sprites/manivela_sprite

var indice_frame: int = 0
var cor_atual: Color = Color.WHITE


func _ready() -> void:
	interaction_area.interact = Callable(self, "girar_manivela")
	
	if cores.is_empty():
		return
	
	_atualizar_cor()


func girar_manivela() -> void:
	manivela_sprite.scale.y *= -1
	
	indice_frame += 1
	
	if indice_frame >= cristal_sprite.hframes:
		indice_frame = 0
	
	cristal_sprite.frame = indice_frame
	
	_atualizar_cor()


func _atualizar_cor() -> void:
	if cores.is_empty():
		return
	
	if indice_frame >= cores.size():
		return
	
	cor_atual = cores[indice_frame]
	cor_alterada.emit(cor_atual)
