class_name PlayerMovendo
extends Estado

#@export var animation_player: AnimationPlayer
@export var player_idle: Estado

const NOME_ANIMACAO: String = "andando"

func entrar() -> void:
	#animation_player.play(NOME_ANIMACAO.to_lower())
	pass

func atualizar_fisica(_delta: float) -> void:
	if pegar_direcao() == 0.0: 
		transicionar_estado.emit(self, player_idle)

func pegar_direcao() -> float:
	return Input.get_axis("ui_left", "ui_right")
