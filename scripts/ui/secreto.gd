extends TextureRect

func _ready() -> void:
	# 1. Define o pivô no centro imediatamente
	_atualizar_pivo_no_centro()
	
	# 2. GAMBIARRA ZERO: Conecta ao sinal 'resized'. 
	# Se o TextureRect mudar de tamanho por qualquer motivo, o pivô se auto-corrige na hora.
	resized.connect(_atualizar_pivo_no_centro)

func _atualizar_pivo_no_centro() -> void:
	pivot_offset = size / 2.0


func iniciar_animacao_curva() -> void:
	# 1. Configurações de Posição
	var ponto_inicial: Vector2 = global_position
	var ponto_final: Vector2 = Vector2(800, 500) # Mude para o seu destino
	
	# Cria a "barriga" da curva para cima
	var ponto_controle: Vector2 = (ponto_inicial + ponto_final) / 2 + Vector2(500, 0)
	
	# Salva o tamanho original para os cálculos de centro
	var tamanho_original: Vector2 = size
	var metade_tamanho: Vector2 = tamanho_original / 2.0
	
	var duracao: float = 15
	var voltas: float = 6
	
	# 2. Criando o Tween em paralelo
	var tween: Tween = create_tween().set_parallel(true)
	
	# --- ANIMAÇÃO UNIFICADA (Move, Roda e Encolhe no mesmo eixo) ---
	tween.tween_method(
		func(t: float):
			# A. Calcula a posição atual da curva (o centro real de onde o PNG deveria estar)
			var centro_atual: Vector2 = _calcular_bezier_quadratica(ponto_inicial + metade_tamanho, ponto_controle, ponto_final + metade_tamanho, t)
			
			# B. Calcula o encolhimento progressivo (Linear ou Suave)
			# t vai de 0.0 a 1.0, então (1.0 - t) vai de 1.0 a 0.0
			var escala_atual: float = 1.0 - t 
			scale = Vector2(escala_atual, escala_atual)
			
			# C. Calcula a rotação constante (sem aceleração bizarra)
			rotation = (TAU * voltas) * t
			
			# D. A MÁGICA: Atualiza o pivot_offset em tempo real baseado no tamanho atualizado
			pivot_offset = tamanho_original / 2.0
			
			# E. Ajusta a posição global compensando o pivô para ele não orbitar
			global_position = centro_atual - (pivot_offset * escala_atual),
		0.0, 
		1.0, 
		duracao
	).set_trans(Tween.TRANS_LINEAR) # Mantém a velocidade constante do início ao fim
	
	# Deleta o nó ao terminar
	tween.chain().tween_callback(queue_free)

func _calcular_bezier_quadratica(p0: Vector2, p1: Vector2, p2: Vector2, t: float) -> Vector2:
	var q0: Vector2 = p0.lerp(p1, t)
	var q1: Vector2 = p1.lerp(p2, t)
	return q0.lerp(q1, t)
