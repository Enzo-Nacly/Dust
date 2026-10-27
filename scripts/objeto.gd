class_name Objeto
extends StaticBody2D

var planeta: Planeta
var componente_rotacao: ComponenteRotacao

func _ready() -> void:
	componente_rotacao = $ComponenteRotacao
	componente_rotacao.setup(self)

	var planetas = get_tree().get_nodes_in_group("planets")
	if planetas.size() > 0:
		planeta = planetas[0] as Planeta

func _process(_delta: float) -> void:
	var forca_gravitacional: Vector2 = planeta.pegar_gravidade_em(global_position)

	if forca_gravitacional != Vector2.ZERO:
		var vetor_centro: Vector2 = forca_gravitacional.normalized()
		componente_rotacao.atualizar_rotacao()
