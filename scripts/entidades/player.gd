class_name Player
extends Movel

@export var inventario: Inventario

#@onready var
#@onready var
@onready var componente_animacao: ComponenteAnimacao = get_node("Componentes/ComponenteAnimacao")
@onready var componente_movimento: ComponenteMovimento = get_node("Componentes/ComponenteMovimento")
@onready var componente_pulo: ComponentePulo = get_node("Componentes/ComponentePulo")
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	Game_Manager.on_dialog.connect(func(): Game_Manager.can_move = false)
	Game_Manager.out_dialog.connect(func(): Game_Manager.can_move = true)
	
	_setar_inventario_gerenciador()

func _pegando_direcao() -> int:
	var direcao: int = int(Input.get_axis("esquerda", "direita"))
	return direcao


func _physics_process(delta: float) -> void:
	if Game_Manager.can_move == false: return
	
	var direcao = _pegando_direcao()
	componente_animacao.mudar_direcao_sprite(direcao)
	componente_animacao.animar(direcao)
	
	componente_movimento.mover(delta, direcao)
	
	processar_fisica_basica(delta)
	
	componente_pulo.pular()
	
	finalizar_fisica()

func _setar_inventario_gerenciador() -> void:
	GerenciadorInventario.inventario = inventario
