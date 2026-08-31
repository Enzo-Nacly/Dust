class_name UIInventario
extends Control

var textura_itens: Array[Texture2D]

func _ready() -> void:
	fechar()
	for slot in $VBoxContainer.get_children():
		textura_itens.append(slot.get_child(0))

func adicionar_textura_slot(index_slot: int, textura: Texture2D) -> void:
	textura_itens[index_slot] = textura

func abrir() -> void:
	self.visible = true

func fechar() -> void:
	self.visible = false
