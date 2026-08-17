class_name Lupa
extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var luz_feixe: PointLight2D = $luz_feixe

var plantas: Array[Planta] = []
var indice_planta: int = 0
var cor_luz: Color = Color.WHITE


func _ready() -> void:
	interaction_area.interact = Callable(self, "mudar_direcao")

func configurar_plantas(novas_plantas: Array[Planta]) -> void:
	plantas = novas_plantas
	
	if plantas.is_empty():
		return
	
	indice_planta = 0
	_apontar_para_planta()


func definir_cor_luz(nova_cor: Color) -> void:
	cor_luz = nova_cor
	luz_feixe.color = cor_luz
	
	if plantas.is_empty():
		return
	
	plantas[indice_planta].receber_luz(cor_luz)


func mudar_direcao() -> void:
	if plantas.is_empty():
		return
	
	plantas[indice_planta].parar_de_receber_luz()
	
	indice_planta += 1
	
	if indice_planta >= plantas.size():
		indice_planta = 0
	
	_apontar_para_planta()


func _apontar_para_planta() -> void:
	var planta: Planta = plantas[indice_planta]
	
	var direcao: Vector2 = planta.global_position - luz_feixe.global_position
	luz_feixe.rotation = direcao.angle() + deg_to_rad(55.0) + PI / 2.0
	
	planta.receber_luz(cor_luz)
