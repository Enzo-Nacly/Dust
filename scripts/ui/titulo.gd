extends Label

const SOM_CLICK: AudioStream = preload("res://assets/sonoro/sfx/hover_botao.wav")
const DURACAO_ANIMACAO: float = 0.1

@export var variacao_pitch: float = 0.3
@export var dimunuicao_x_y: float = 0.7

@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

var clicavel: bool = false
var scale_original: Vector2 = Vector2.ONE
var scale_dimunuido: Vector2 = Vector2.ZERO

func _ready() -> void:
	scale_dimunuido = Vector2(dimunuicao_x_y, dimunuicao_x_y)
	scale_original = self.scale
	
	pivot_offset = size / 2.0
	# Garante que o pivô atualize se o botão mudar de tamanho dinamicamente
	resized.connect(func(): pivot_offset = size / 2.0)
	
	audio_stream_player.stream = SOM_CLICK

func _tocar_audio(inicio: float = 0.0) -> void:
	var acrescimo_variacao_pitch: float = randf_range(-variacao_pitch, variacao_pitch)
	
	audio_stream_player.pitch_scale = (1 + acrescimo_variacao_pitch)
	audio_stream_player.play(inicio)

func _animar_bowing():
	var tween_bowing: Tween = create_tween()
	
	tween_bowing.set_trans(Tween.TRANS_BACK)
	tween_bowing.set_ease(Tween.EASE_OUT)
	
	tween_bowing.tween_property(self, "scale", scale_dimunuido, DURACAO_ANIMACAO)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN)
	
	tween_bowing.tween_property(self, "scale", scale_original, 3 * DURACAO_ANIMACAO)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_OUT)

func _on_gui_input(event: InputEvent) -> void:
	if not clicavel: return
	if event is not InputEventMouseButton: return
	if not (event.button_index == MOUSE_BUTTON_LEFT and event.pressed): return
	
	_tocar_audio()
	_animar_bowing()
