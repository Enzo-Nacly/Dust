extends Sprite2D

const VELOCIDADE: float = 16.5
const ROTACAO_CLIQUE: float = - 25.0
const ESCALA_CLIQUE: Vector2 = Vector2(0.35, 0.35)

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(delta: float) -> void:
	_posicionar(delta)
	
	_on_clique(delta)

func _posicionar(delta: float) -> void:
	self.global_position = lerp(self.global_position, get_global_mouse_position(), VELOCIDADE * delta)

func _on_clique(delta: float) -> void:
	var rotacao_querida: float = ROTACAO_CLIQUE if Input.is_action_just_pressed("mouse_esquerdo") else 0.0
	self.rotation_degrees = lerp(self.rotation_degrees, rotacao_querida, VELOCIDADE * delta)
	
	var escala_querida: Vector2 = ESCALA_CLIQUE if Input.is_action_just_pressed("mouse_esquerdo") else Vector2(1.0, 1.0)
	self.scale = lerp(self.scale, escala_querida, VELOCIDADE * delta)
