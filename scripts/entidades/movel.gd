class_name Movel
extends CharacterBody2D

@onready var componente_gravidade: ComponenteGravidade = get_node("Componentes/ComponenteGravidade")
@onready var componente_rotacao: ComponenteRotacao = get_node("Componentes/ComponenteRotacao")

func _physics_process(delta: float) -> void:
	processar_fisica_basica(delta)
	finalizar_fisica()

func processar_fisica_basica(delta: float) -> void:
	if componente_gravidade:
		componente_gravidade.aplicar_gravidade(delta)
		
	if componente_rotacao:
		componente_rotacao.atualizar_rotacao()
		
	var vetor_centro: Vector2 = componente_gravidade.vetor_centro
	_processar_orientacao(vetor_centro)

func finalizar_fisica() -> void:
	self.move_and_slide()

func _processar_orientacao(vetor_centro: Vector2) -> void:
	if vetor_centro == Vector2.ZERO:
		self.motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
		return

	self.up_direction = -vetor_centro
	self.motion_mode = CharacterBody2D.MOTION_MODE_GROUNDED
