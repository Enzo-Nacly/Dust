class_name Quinoyd
extends Movel

@export var ativar_instantaneamente: bool
@export var ativar_one_shot: bool
@export var dialogo: Array[DialogoExport]

@onready var area_dialogo_quinoyd: AreaDialogoQuinoyd = $area_dialogo_quinoyd
@onready var componente_animacao: ComponenteAnimacao = get_node("Componentes/ComponenteAnimacao")
@onready var componente_movimento: ComponenteMovimento = get_node("Componentes/ComponenteMovimento")
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	area_dialogo_quinoyd.ativar_instantaneamente = self.ativar_instantaneamente
	area_dialogo_quinoyd.ativar_one_shot = self.ativar_one_shot
	area_dialogo_quinoyd.dialogo = self.dialogo

func _pegando_direcao() -> int:
	var direcao: int = int(Input.get_axis("andar_quinoyd_L", "andar_quinoyd_R"))
	return direcao

func _physics_process(delta: float) -> void:
	if Game_Manager.can_move == false: return
	
	var direcao = _pegando_direcao()
	componente_animacao.mudar_direcao_sprite(direcao)
	#componente_animacao.animar(direcao)
	
	componente_movimento.mover(delta, direcao)
	
	processar_fisica_basica(delta)
	
	#componente_pulo.pular()
	
	finalizar_fisica()
