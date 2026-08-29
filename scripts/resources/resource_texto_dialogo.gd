class_name TextoDialogo
extends DialogoExport

#@export var nome_falante: String

@export var imagem_falante: Texture
@export var qtd_frames_falante: int = 1
@export var frame_falante_terminou: int = 0

@export_multiline var texto: String
@export_range(0.1, 30.0, 0.1) var velocidade_texto: float = 1.0

@export var som_texto: AudioStream
@export var volume_texto_db: int
@export var volume_texto_pitch_min: float = 0.85
@export var volume_texto_pitch_max: float = 1.15

@export var posicao_camera: Vector2 = Vector2(999.999,  999.999)
@export_range(0.05, 10.0, 0.05) var tempo_transicao_camera: float = 1.0
