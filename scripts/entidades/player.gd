class_name Player
extends Movel

@onready var componente_movimento: ComponenteMovimento = get_node("Componentes/ComponenteMovimento")
@onready var componente_pulo: ComponentePulo = get_node("Componentes/ComponentePulo")
@onready var animacao: AnimationPlayer = $MaquinaEstados/AnimationPlayer
@onready var visual: Node2D = $MaquinaEstados

enum States {idle, running, jumping}


func _ready() -> void:
	Game_Manager.on_dialog.connect(func(): Game_Manager.can_move = false)
	Game_Manager.out_dialog.connect(func(): Game_Manager.can_move = true)

func movimento() -> int:
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		animacao.play("andando")
		var direcao: int = int(Input.get_axis("left", "right"))
		if direcao < 0: visual.scale.x = -1
		elif direcao > 0: visual.scale.x = 1
		return direcao
	else:
	
		animacao.play("idle")
		return 0

func _physics_process(delta: float) -> void:
	if Game_Manager.can_move == true:
		var direcao = movimento()
		componente_movimento.mover(delta, direcao)
		processar_fisica_basica(delta)
		componente_pulo.pular()
		finalizar_fisica()
