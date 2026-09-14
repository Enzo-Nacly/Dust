class_name SlotInventario
extends Panel

@onready var textura_item: TextureRect = $textura_item

func definir_textura(item: ItemInventario) -> void:
	if item == null:
		textura_item.texture = null
		return

	textura_item.texture = item.textura
