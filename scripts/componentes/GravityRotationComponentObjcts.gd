class_name GravityRotationObjctsComponent
extends Node

@export var velocidade_giro: float = 10.0
@export var offset_angulo_graus: float = -90.0

var planet: Node
var alvo: Node2D

func _ready() -> void:
	alvo = get_parent() as Node2D
	
	var planets_group = get_tree().get_nodes_in_group("planets")
	if planets_group.size() > 0:
		planet = planets_group[0]

func _process(delta: float) -> void:
	if not planet or not alvo:
		return
		
	var forca_gravitacional: Vector2 = planet.pegar_gravidade_em(alvo.global_position)

	if forca_gravitacional != Vector2.ZERO:

		var offset_radianos: float = deg_to_rad(offset_angulo_graus)
		var angulo_alvo: float = forca_gravitacional.angle() + offset_radianos
		
		alvo.global_rotation = lerp_angle(alvo.global_rotation, angulo_alvo, velocidade_giro * delta)
