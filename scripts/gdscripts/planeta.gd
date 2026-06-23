class_name Planeta
extends StaticBody2D

@export var planeta_status: PlanetaStatus
	
var componente_gravidade: ComponenteGravidade
var forma_colisao: CollisionShape2D
var sprite: Sprite2D

func _ready() -> void:
	componente_gravidade = $ComponenteGravidade
	forma_colisao = $CollisionShape2D
	sprite = $Sprite2D 

	componente_gravidade.setup(self, planeta_status.raio)

	if forma_colisao.shape is CircleShape2D:
		forma_colisao.shape.radius = planeta_status.raio

	_ajustar_tamanho_do_sprite()

func _ajustar_tamanho_do_sprite() -> void:
	if sprite.texture == null: 
		return

	var tamanho_original_da_imagem: float = sprite.texture.get_size().x
	var diametro_desejado: float = planeta_status.raio * 2
	var nova_escala: float = diametro_desejado / tamanho_original_da_imagem

	sprite.scale = Vector2(nova_escala, nova_escala)

func pegar_gravidade_em(posicao_particula: Vector2) -> Vector2:
	return componente_gravidade.pegar_gravidade_em(posicao_particula)
