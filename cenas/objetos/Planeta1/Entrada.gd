extends Area2D
class_name Entrada

@export var anterior: Entrada

@onready var animacao: AnimationPlayer = get_node_or_null("AnimationPlayer")
@onready var sprite: Sprite2D = get_node_or_null("AnimationPlayer/Sprite2D")
var posicao = 0


@onready var camera: Camera2D = $Camera2D
var dentro = false
var tween: Tween
var esperando_w = false

const ANIM_ENTRAR := "EInteracao"
const ANIM_SAIR := "Interação Saida"

func _ready() -> void:
	camera.enabled = false
	body_entered.connect(_on_player_entrou)
	body_exited.connect(_on_player_saiu)
	alternar_colisoes_vizinhas(true)
	for filho in get_children():
		if filho is CollisionShape2D or filho is CollisionPolygon2D:
			posicao = filho.global_position
		
	
	
	if sprite:
		sprite.visible = false
		sprite.z_as_relative = false
		sprite.z_index = 4096
		sprite.global_position = posicao + global_transform.y * -30
		sprite.global_rotation = global_rotation

func _mostrar_icone() -> void:
	if sprite and animacao:
		sprite.visible = true
		
		animacao.play("Interação Saida")

func _esconder_icone() -> void:
	if sprite and animacao:
		sprite.visible = false

func _on_player_entrou(body: Node2D) -> void:
	if not (body.is_in_group("player") or body.name == "Player"):
		return

	_mostrar_icone()

	if esperando_w:
		return
	esperando_w = true

	while body in get_overlapping_bodies():
		await get_tree().process_frame
		if not Input.is_action_just_pressed("entrar_sair"):
			continue

		if tween: tween.kill()
		tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

		dentro = !dentro
		_mostrar_icone()  # troca o ícone conforme o estado

		if dentro:
			camera.enabled = true
			camera.make_current()

			print("Player Entrou")
			tween.tween_property(self, "modulate:a", 0.0, 0.5)

			aplicar_colisoes_de_entrada()
		else:
			print("Player Saiu")
			camera.enabled = false
			camera.make_current()
			tween.tween_property(self, "modulate:a", 1.0, 0.5)

			alternar_colisoes_vizinhas(true)

			if anterior:
				alternar_colisoes_descendentes(false)
				anterior.aplicar_colisoes_de_entrada()
			else:
				alternar_colisoes_descendentes(true)

	esperando_w = false

func _on_player_saiu(body: Node2D) -> void:
	if not (body.is_in_group("player") or body.name == "Player"):
		return
	_esconder_icone()

func aplicar_colisoes_de_entrada() -> void:
	alternar_colisoes_vizinhas(false)
	alternar_colisoes_descendentes(true)

func alternar_colisoes_vizinhas(deve_desativar: bool) -> void:
	var nos_para_checar: Array = []

	for irmao in get_parent().get_children():
		if irmao != self:
			nos_para_checar.append(irmao)

	_aplicar(nos_para_checar, deve_desativar)

func alternar_colisoes_descendentes(deve_desativar: bool) -> void:
	var nos_para_checar: Array = []

	for filho in get_children():
		if filho is CollisionShape2D or filho is CollisionPolygon2D:
			continue
		nos_para_checar.append(filho)

	_aplicar(nos_para_checar, deve_desativar)

func _aplicar(nos_para_checar: Array, deve_desativar: bool) -> void:
	while nos_para_checar.size() > 0:
		var no_atual = nos_para_checar.pop_front()

		if no_atual is CollisionShape2D or no_atual is CollisionPolygon2D:
			no_atual.set_deferred("disabled", deve_desativar)

		for filho in no_atual.get_children():
			nos_para_checar.append(filho)
