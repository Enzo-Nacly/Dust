class_name PlayerIdle
extends Estado

@export var animation_player: AnimationPlayer
@export var player_movendo: Estado

const NOME_ANIMACAO: String = "idle"

func entrar() -> void:
	animation_player.play(NOME_ANIMACAO.to_lower())

func atualizar() -> void:
	if Input.get_axis("ui_left", "ui_right") != 0.0:
		transicionar_estado.emit(self, player_movendo)
