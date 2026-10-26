class_name Empurravel
extends Movel

@onready var componente_movimento: ComponenteMovimento = $Componentes/ComponenteEmpurrar

var direcao_recebida: int = 0
var sendo_empurrada_neste_frame: bool = false

func _physics_process(delta: float) -> void:
	# Se não recebeu nenhum comando de empurrão neste frame, a direção é 0 (aplica atrito)
	if not sendo_empurrada_neste_frame:
		direcao_recebida = 0
		
	# Chama o seu componente fantástico que já calcula aceleração e atrito!
	if componente_movimento:
		componente_movimento.mover(delta, direcao_recebida)
		
	# Executa o movimento físico padrão do CharacterBody2D
	move_and_slide()
	
	# Reseta a flag para o próximo frame
	sendo_empurrada_neste_frame = false

# Esta é a função que o componente do jogador vai chamar todo frame enquanto empurrar
func receber_empurrao(direcao: int) -> void:
	direcao_recebida = direcao
	sendo_empurrada_neste_frame = true
