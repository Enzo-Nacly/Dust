class_name Player
extends CharacterBody2D

var componente_movimento: ComponenteMovimento
var componente_rotacao: ComponenteRotacao
var componente_pulo: ComponentePulo
var planeta: Planeta

func _ready() -> void:
	# Ajuste esses caminhos conforme o nome exato dos nós na sua cena
	componente_movimento = $Componentes/ComponenteMovimento
	componente_rotacao = $Componentes/ComponenteRotacao
	componente_pulo = $Componentes/ComponentePulo

	var planetas = get_tree().get_nodes_in_group("planets")
	if planetas.size() > 0:
		planeta = planetas[0] as Planeta

	componente_movimento.setup(self)
	componente_rotacao.setup(self)
	componente_pulo.setup(self)

func _physics_process(delta: float) -> void:
	componente_movimento.mover(delta)

	var forca_gravitacional: Vector2 = planeta.pegar_gravidade_em(global_position)

	if forca_gravitacional != Vector2.ZERO:
		var vetor_centro: Vector2 = forca_gravitacional.normalized()
		componente_rotacao.atualizar_rotacao(vetor_centro)

		up_direction = -vetor_centro
		motion_mode = CharacterBody2D.MOTION_MODE_GROUNDED
		componente_pulo.pular(vetor_centro)

		velocity += forca_gravitacional * delta
	else:
		motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	
	move_and_slide()
