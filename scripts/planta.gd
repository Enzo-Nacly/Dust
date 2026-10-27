class_name Planta
extends Node2D

@export var debug: bool = false
@export var luz_crescimento: Color = Color.WHITE
@export var velocidade_crescimento: float = 0.5
@export var velocidade_decrescimento: float = 0.8

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var luz_em_mim: bool = false
var luz_recebida: Color = Color.WHITE

var progresso: float = 0.0
var duracao_animacao: float = 0.0


func _ready() -> void:
	var animacao: Animation = animation_player.get_animation("crescendo_morrendo")
	if animacao: duracao_animacao = animacao.length
	else:
		push_error("Planta '%s' não possui a animação 'crescendo_morrendo'." % name)


func _process(delta: float) -> void:
	var luz_correta: bool = luz_recebida == luz_crescimento

	var pode_crescer := luz_em_mim and luz_correta

	if pode_crescer:
		progresso += velocidade_crescimento * delta
	else:
		progresso -= velocidade_decrescimento * delta
	
	progresso = clamp(progresso, 0.0, duracao_animacao)
	
	animation_player.seek(progresso, true)
	
	if debug:
		print(
			"recebendo luz: ", luz_em_mim,
			" | cor correta: ", luz_correta,
			" | progresso: ", progresso
		)


func receber_luz(cor: Color) -> void:
	luz_em_mim = true
	luz_recebida = cor

	if debug:
		print("Luz recebida: ", luz_recebida)


func parar_de_receber_luz() -> void:
	luz_em_mim = false

	if debug:
		print("Parou de receber luz.")
