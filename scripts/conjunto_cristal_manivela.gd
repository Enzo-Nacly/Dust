class_name Cristal
extends Node2D

signal cor_alterada(cor: Color)

const NUM_FRAMES_CRISTAL: int = 8
const PITCH_MINIMO: float = 0.7
const PITCH_MAXIMO: float = 1.0

@export var cores: Array[Color] = [Color.BLUE, Color.RED, Color.GREEN, Color.YELLOW,
								   Color.PURPLE, Color.ORANGE, Color.CYAN, Color.DARK_SALMON]:
	set(novo_array):
		novo_array.resize(NUM_FRAMES_CRISTAL)
		cores = novo_array

@onready var interaction_area: AreaInteracao = $InteractionArea
@onready var cristal_sprite: Sprite2D = $Sprites/cristal_sprite
@onready var manivela_sprite: Sprite2D = $Sprites/manivela_sprite
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

var indice_frame: int = 0
var cor_atual: Color = Color.WHITE


func _ready() -> void:
	interaction_area.interact = Callable(self, "girar_manivela")
	
	if cores.is_empty():
		return
	
	_atualizar_cor()


func girar_manivela() -> void:
	manivela_sprite.scale.y *= -1
	
	indice_frame += 1
	
	if indice_frame >= cristal_sprite.hframes:
		indice_frame = 0
	
	var duracao_total: float = _tocar_sfx()
	
	# Espera metade da duração real do áudio antes de trocar o sprite
	if duracao_total > 0.0:
		await get_tree().create_timer(duracao_total / 2.0).timeout
	
	cristal_sprite.frame = indice_frame
	
	_atualizar_cor()


func _atualizar_cor() -> void:
	if cores.is_empty():
		return
	
	if indice_frame >= cores.size():
		return
	
	cor_atual = cores[indice_frame]
	cor_alterada.emit(cor_atual)

func _tocar_sfx() -> float:
	if not audio_player.stream:
		return 0.0
		
	var pitch: float = _pitch_som()
	audio_player.pitch_scale = pitch
	audio_player.play()
	
	# Retorna o tempo real que o som vai levar para tocar por completo
	return audio_player.stream.get_length() / pitch

func _pitch_som() -> float:
	var valor = randf_range(PITCH_MINIMO, PITCH_MAXIMO)
	return snappedf(valor, 0.1)
