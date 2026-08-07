class_name Player
extends Movel

@onready var componente_movimento: ComponenteMovimento = get_node("Componentes/ComponenteMovimento")
@onready var componente_pulo: ComponentePulo = get_node("Componentes/ComponentePulo")
@onready var sprite: Sprite2D = $Sprite2D
func _ready() -> void:
	Game_Manager.on_dialog.connect(func(): Game_Manager.can_move = false)
	Game_Manager.out_dialog.connect(func(): Game_Manager.can_move = true)

func movimento() -> int:
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		var direcao: int = int(Input.get_axis("left", "right"))
		if direcao < 0: sprite.flip_h = true
		else: sprite.flip_h = false
		return direcao
	else:
		return 0

func _physics_process(delta: float) -> void:
	if Game_Manager.can_move == true:
		var direcao = movimento()
		componente_movimento.mover(delta, direcao)
		processar_fisica_basica(delta)
		componente_pulo.pular()
		finalizar_fisica()
