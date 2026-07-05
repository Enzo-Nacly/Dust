class_name Player
extends Movel

@onready var componente_movimento: ComponenteMovimento = get_node("Componentes/ComponenteMovimento")
@onready var componente_pulo: ComponentePulo = get_node("Componentes/ComponentePulo")

func _physics_process(delta: float) -> void:
	var direcao: int = int(Input.get_axis("ui_left", "ui_right"))
	componente_movimento.mover(delta, direcao)
	
	processar_fisica_basica(delta)
	
	componente_pulo.pular()
	
	finalizar_fisica()
