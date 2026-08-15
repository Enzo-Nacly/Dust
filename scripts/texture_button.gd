extends TextureButton

@export var escala_hover: float = 1.15
@export var duracao: float = 0.02 #isso aq vai mudar o quao rapido ele faz a animacao de hover

func _ready() -> void:
	pivot_offset = size / 2
	resized.connect(func(): pivot_offset = size / 2)
	mouse_entered.connect(_atualizar_estado)
	mouse_exited.connect(_atualizar_estado)
	focus_entered.connect(_atualizar_estado)
	focus_exited.connect(_atualizar_estado)
	pressed.connect(_pressionado)
func _atualizar_estado() -> void:
	var ativo := is_hovered() or has_focus() 
	var alvo := Vector2(escala_hover, escala_hover) if ativo else Vector2.ONE
	create_tween().tween_property(self, "scale", alvo, duracao)
func _pressionado() -> void:
	create_tween().tween_property(self, "scale", Vector2(0.95, 0.95), 0.000001)
	modulate = Color(0.71, 0.79, 0.77) # muda a cor do botao qnd apertado
	await get_tree().create_timer(0.15).timeout
	create_tween().tween_property(self, "scale", Vector2(escala_hover, escala_hover), 0.000001)
	modulate = Color.WHITE
	
