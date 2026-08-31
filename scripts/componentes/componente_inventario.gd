class_name ComponenteInventario
extends Node

const ui_inventario_preload: PackedScene = preload("res://cenas/ui/inventario/ui_inventario.tscn")

@export var inventario: Inventario

var ui_inventario: Control = null

func _ready() -> void:
	ui_inventario = ui_inventario_preload.instantiate()
	ui_inventario.visible = false
