class_name ComponenteEmpurrar
extends Node

signal push_started
signal push_ended

@export var forca_empurro: float = 50.0
@export var seta_objeto: RayCast2D
@export var seta_empurro: RayCast2D

@onready var entidade: CharacterBody2D = self.owner
@onready var alvo_seta_empurro = seta_empurro.target_position
@onready var alvo_seta_objeto = seta_objeto.target_position

func _physics_process(_delta: float) -> void:

	# espelhar raycasts baseado no movimento
	if entidade.velocity.x < 0:
		seta_empurro.target_position = -alvo_seta_empurro
		seta_objeto.target_position = -alvo_seta_objeto
		
	elif entidade.velocity.x > 0:
		seta_empurro.target_position = alvo_seta_empurro
		seta_objeto.target_position = alvo_seta_objeto
	
	# detectar contato com o objeto empurrável
	if seta_objeto.is_colliding():
		emit_signal("push_started")
	
	else:
		emit_signal("push_ended")
		return
		
	# se não está tocando "empurrável", parar aqui
	if not seta_empurro.is_colliding():
		return

	var collider = seta_empurro.get_collider()

	if collider is Movel and collider.is_in_group("empurravel"):
		# Descobre a direção do empurrão baseada na normal da colisão (invertida)
		var direction = -seta_empurro.get_collision_normal()
		
		# Aplica a velocidade diretamente no eixo X do objeto empurrado
		collider.velocity.x = direction.x * forca_empurro
		
		# IMPORTANTE: Garante que o objeto empurrado rode o move_and_slide() dele
		if collider.has_method("move_and_slide"):
			collider.move_and_slide()
