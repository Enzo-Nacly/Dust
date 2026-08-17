class_name PuzzleCristal
extends Node2D

@export var plantas: Array[Planta] = []

@onready var cristal: Cristal = $conjunto_cristal_manivela
@onready var lupa: Lupa = $lupa


func _ready() -> void:
	lupa.configurar_plantas(plantas)
	
	cristal.cor_alterada.connect(_on_cor_cristal_alterada)
	
	_on_cor_cristal_alterada(cristal.cor_atual)


func _on_cor_cristal_alterada(cor: Color) -> void:
	lupa.definir_cor_luz(cor)
