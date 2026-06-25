class_name PlayerMovendo
extends Estado

@export var animation_player: AnimationPlayer
@export var componente_movimento: ComponenteMovimento
@export var player_idle: Estado

const NOME_ANIMACAO: String = "andando"

func entrar() -> void:
	animation_player.play(NOME_ANIMACAO.to_lower())

func atualizar_fisica(delta: float) -> void:
	var direcao: float = Input.get_axis("ui_left", "ui_right")
	if direcao == 0.0: 
		transicionar_estado.emit(self, player_idle)
		return
	
	#componente_movimento.mover(delta, direcao)
