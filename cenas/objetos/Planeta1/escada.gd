class_name PontoEscada
extends Area2D

@export var destino: PontoEscada

@onready var animacao: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

var jogador: Node2D = null

func _ready() -> void:
	sprite.visible = false
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	jogador = body
	sprite.visible = true
	animacao.play("Interação Saida")

func _on_body_exited(body: Node2D) -> void:
	if body != jogador:
		return
	jogador = null
	animacao.stop()
	sprite.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if jogador == null or destino == null:
		return
	if event.is_action_pressed("entrar_sair"):
		jogador.global_position = destino.global_position
