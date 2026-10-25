#class_name MenuCorpo
extends TextureRect

@export var amplitude: float = 2
@export var velocidade: float = 5.0
const MULTIPLICADOR: float = 0.1

var pode_mover: bool = true
var tempo: float = 0.0
var operador: int = 1

func _ready() -> void:
	amplitude *= MULTIPLICADOR

func _process(delta: float) -> void:
	if not pode_mover: return
	
	tempo += operador * delta * velocidade

	if tempo >= TAU:
		tempo = TAU
		operador = -1
		
	elif tempo <= 0.0:
		tempo = 0.0
		operador = 1
		
	_movimento_sinoidal()

func _movimento_sinoidal() -> void:
	var acrescimo = remap(tempo, 0.0, TAU, -amplitude, amplitude)
	self.position.y += acrescimo
