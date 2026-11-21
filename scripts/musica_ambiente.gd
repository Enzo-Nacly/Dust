class_name MusicaAmbiente
extends AudioStreamPlayer2D

const DURACAO_ESPERA: float = 5.0
const DURACAO_TWEEN: float = 10.0

var tween_atual: Tween
var volume_alvo_db: float

func _ready() -> void:
	volume_alvo_db = self.volume_db
	
	self.volume_db = linear_to_db(0.0)
	
	await esperar()
	fade_in_out(true)

func _process(_delta: float) -> void:
	if self.playing: return
	
	await esperar()
	fade_in_out(true)

func mudar_volume(novo_volume_db: float) -> void:
	volume_alvo_db = novo_volume_db
	
	if self.playing and (not tween_atual or not tween_atual.is_running()):
		self.volume_db = novo_volume_db

func esperar(tempo: float = DURACAO_ESPERA) -> void:
	await get_tree().create_timer(tempo).timeout

func mudar_musica_ambiente(nova_musica: AudioStream) -> void:
	self.stream = nova_musica

func fade_in_out(fade_in: bool) -> void:
	if tween_atual and tween_atual.is_valid():
		tween_atual.kill()
		
	tween_atual = create_tween()
	
	var volume_inicial: float = max(0.0, db_to_linear(self.volume_db))
	
	if fade_in:
		if not self.playing:
			self.volume_db = linear_to_db(0.0)
			volume_inicial = 0.0
			self.play()
			
		var volume_destino: float = db_to_linear(volume_alvo_db)
		tween_atual.tween_method(atualizar_volume, volume_inicial, volume_destino, DURACAO_TWEEN)
	else:
		tween_atual.tween_method(atualizar_volume, volume_inicial, 0.0, DURACAO_TWEEN)
		tween_atual.tween_callback(self.stop)

func atualizar_volume(valor_linear: float) -> void:
	self.volume_db = linear_to_db(max(0.0, valor_linear))
