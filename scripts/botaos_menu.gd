extends Button

const SOM_HOVER: AudioStream = preload("res://assets/sonoro/sfx/hover_botao.wav")
const DURACAO_ANIMACAO: float = 0.15

@export var variacao_pitch: float = 0.3
@export var aumento_x_y: float = 1.2

@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

var tween_selecao: Tween
var scale_original: Vector2 = Vector2.ONE
var scale_hover: Vector2 = Vector2.ZERO

func _ready() -> void:
	scale_hover = Vector2(aumento_x_y, aumento_x_y)
	self.scale = scale_original
	
	pivot_offset = size / 2.0
	# Garante que o pivô atualize se o botão mudar de tamanho dinamicamente
	resized.connect(func(): pivot_offset = size / 2.0)
	
	audio_stream_player.stream = SOM_HOVER
	
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered() -> void:
	if self.disabled: return
	
	_tocar_audio()
	_anima_scale(scale_hover)

func _on_mouse_exited() -> void:
	if self.disabled: return
	
	_anima_scale(scale_original)

func _tocar_audio(inicio: float = 0.0) -> void:
	var acrescimo_variacao_pitch: float = randf_range(-variacao_pitch, variacao_pitch)
	
	audio_stream_player.pitch_scale = (1 + acrescimo_variacao_pitch)
	audio_stream_player.play(inicio)

func _anima_scale(target_scale: Vector2) -> void:
	if tween_selecao and tween_selecao.is_running():
		tween_selecao.kill()
		
	# Cria a animação suave de transição
	tween_selecao = create_tween().set_ease(tween_selecao.EASE_OUT).set_trans(tween_selecao.TRANS_QUAD)
	tween_selecao.tween_property(self, "scale", target_scale, DURACAO_ANIMACAO)
