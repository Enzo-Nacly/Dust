class_name Lupa
extends Node2D

const ACRESIMO_RADIANOS_ROTACAO_FEIXE: float = deg_to_rad(55.0)

@export_range(-180.0, 180.0, 1.0)
var ajuste_rotacao_feixe_graus: float = 0.0

@onready var interaction_area: AreaInteracao = $InteractionArea
@onready var luz_feixe: PointLight2D = $luz_feixe

var plantas: Array[Planta] = []
var indice_planta: int = 0
var cor_luz: Color = Color.WHITE


func _ready() -> void:
	interaction_area.interact = Callable(self, "mudar_direcao")
	luz_feixe.range_item_cull_mask = 1 << 1
	
	
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
	if plantas.is_empty():
		return

	var planta: Planta = plantas[indice_planta]

	# Direção da luz até a planta, em coordenadas globais.
	var direcao: Vector2 = (
		planta.global_position - luz_feixe.global_position
	)

	if direcao.is_zero_approx():
		return

	# Usa a rotação global para apontar na direção calculada.
	luz_feixe.global_rotation = (
		direcao.angle()
		+ deg_to_rad(ajuste_rotacao_feixe_graus)
	)

	planta.receber_luz(cor_luz)
