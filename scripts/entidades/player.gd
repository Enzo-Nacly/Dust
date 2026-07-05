class_name Player
extends Movel

@onready var mef: MaquinaEstadoFinito = get_node("MaquinaEstadoFinito")
@onready var componente_movimento: ComponenteMovimento = get_node("Componentes/ComponenteMovimento")
@onready var componente_pulo: ComponentePulo = get_node("Componentes/ComponentePulo")

func _physics_process(delta: float) -> void:
	var direcao: float = mef.pegar_direcao()
	componente_movimento.mover(delta, direcao)
	
	processar_fisica_basica(delta)
	
	if Input.is_action_just_pressed("ui_accept"):
		componente_pulo.pular()
	
	finalizar_fisica()
