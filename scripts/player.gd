class_name Player
extends CharacterBody2D

@onready var movement_component : MovementComponent = $Components/Movement_Componet
@onready var rotation_component : Rotation_Component = $Components/Rotation_Component
@onready var jump_component : Jump_Component = $Components/Jump_Component
@onready var planet : Planet = get_tree().get_nodes_in_group("planets")[0]

func _ready() -> void:
	movement_component.setup(self)
	rotation_component.setup(self)
	jump_component.setup(self)
	

func _physics_process(delta: float) -> void:
	movement_component.mover()
	
	var forca_gravitacional : Vector2 = planet.pegar_gravidade_em(self.global_position)
	
	# se o explorer não está fora de um corpo celeste
	if forca_gravitacional != Vector2.ZERO:
		var vetor_centro : Vector2 = forca_gravitacional.normalized()
		rotation_component.atualizar_rotacao(vetor_centro)
		
		# settando corretamente em relação ao planeta
		self.up_direction = -vetor_centro
		
		# atualizando o motion_mode para não quebrar o .is_on_floor() no jump_component
		self.motion_mode = CharacterBody2D.MOTION_MODE_GROUNDED
		jump_component.pular(vetor_centro)
		
		# aplicando gravidade a entidade
		self.velocity += forca_gravitacional * delta
	else:
			# atualizando o motion_mode para não quebrar o .is_on_floor() no jump_component
			self.motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	
	move_and_slide()
