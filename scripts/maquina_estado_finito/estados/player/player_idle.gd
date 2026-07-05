class_name PlayerIdle
extends Estado

#@export var animation_player: AnimationPlayer
@export var player_movendo: PlayerMovendo

const NOME_ANIMACAO: String = "idle"

func entrar() -> void:
	#animation_player.play(NOME_ANIMACAO.to_lower())
	pass

func atualizar_fisica(_delta: float) -> void:
	var direcao: float = Input.get_axis("ui_left", "ui_right")
	if direcao != 0.0: 
		transicionar_estado.emit(self, player_movendo)
