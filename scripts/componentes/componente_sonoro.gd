class_name ComponenteSonoro
extends Node

const PITCH_MINIMO: float = 0.9
const PITCH_MAXIMO: float = 1.0

@onready var entidade: CharacterBody2D = self.owner
@onready var componente_gravidade: ComponenteGravidade = get_node("../ComponenteGravidade")
@onready var audio_player: AudioStreamPlayer2D = get_node("../../AudioStreamPlayer2D")
@onready var sfx_passos_pe: Array[AudioStream] = componente_gravidade.corpo_celeste.sfx_entidades.som_passos

func _escolhendo_audio() -> AudioStream:
	var index: int = randi_range(0, (len(sfx_passos_pe) - 1))
	return sfx_passos_pe[index]

func tocar_sfx() -> void:
	audio_player.stream = _escolhendo_audio()
	audio_player.pitch_scale = _pitch_som()
	audio_player.play()

func _pitch_som() -> float:
	var valor = randf_range(PITCH_MINIMO, PITCH_MAXIMO)
	return snappedf(valor, 0.1)
