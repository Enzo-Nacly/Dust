class_name Planta
extends Node2D

@export var debug: bool = false
@export_enum("Azul", "Vermelho", "Verde", "Amarelo", "Roxo", "Laranja", "Ciano", "Salmão") 
var luz_escolhida: String = "Vermelho":
	set(cor):
		luz_escolhida = cor # SALVA O VALOR CORRETAMENTE
		match cor:
			"Azul": luz_crescimento = Color.BLUE
			"Vermelho": luz_crescimento = Color.RED
			"Verde": luz_crescimento = Color.GREEN
			"Amarelo": luz_crescimento = Color.YELLOW
			"Roxo": luz_crescimento = Color.PURPLE
			"Laranja": luz_crescimento = Color.ORANGE
			"Ciano": luz_crescimento = Color.CYAN
			"Salmão": luz_crescimento = Color.DARK_SALMON

@export var velocidade_crescimento: float = 0.5
@export var velocidade_decrescimento: float = 0.8

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var luz_crescimento: Color
var luz_em_mim: bool = false
var luz_recebida: Color = Color.WHITE
var progresso: float = 0.0
var duracao_animacao: float = 0.0

func _ready() -> void:
	# Sincroniza a cor inicial escolhida no Inspector
	luz_escolhida = luz_escolhida 
	
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
			"recebendo luz?: ", luz_em_mim,
			" | luz recebida: ", _nome_luz_recebida(luz_recebida),
			" | cor correta?: ", luz_correta,
			" | luz correta: ", _nome_luz_recebida(luz_crescimento),
			" | progresso: ", "%.2f" % progresso
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

func _nome_luz_recebida(cor: Color) -> String:
	match cor:
		Color.BLUE: return "Azul"
		Color.RED: return "Vermelho"
		Color.GREEN: return "Verde"
		Color.YELLOW: return "Amarelo"
		Color.PURPLE: return "Roxo"
		Color.ORANGE: return "Laranja"
		Color.CYAN: return "Ciano"
		Color.DARK_SALMON: return "Salmão"
		_: return "Cor não identificada"
