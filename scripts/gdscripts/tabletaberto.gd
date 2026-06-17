extends AnimatedSprite2D

@onready var tabletabertoAnimacao: AnimatedSprite2D = $"."
const SENHA_CORRETA: Array = [1, 2, 3, 4, 5]

var sequencia_digitada = []


#func _on_botao_1_pressed() -> void:
	#adicionar_numero(1)
#
#func _on_botao_2_pressed() -> void:
	#adicionar_numero(2)
#
#func _on_botao_3_pressed() -> void:
	#adicionar_numero(3)
#
#func _on_botao_4_pressed() -> void:
	#adicionar_numero(4)
#
#func _on_botao_5_pressed() -> void:
	#adicionar_numero(5)
	#
#func adicionar_numero(numero: int) -> void:
	#sequencia_digitada.append(numero)
	#print("Digitado: ", numero, " Sequência: ", sequencia_digitada)
	#
	#if sequencia_digitada.size() == SENHA_CORRETA.size():
		#verificar_senha()

func _ready() -> void:
	for child in get_children():
		if child is Button or child is TextureButton:
			# Passamos o número do botão como argumento para a função
			var numero_do_botao = int(child.name.replace("Botao", ""))
			child.pressed.connect(Callable(self, "_on_botao_pressionado").bind(numero_do_botao))

func _on_botao_pressionado(numero: int) -> void:
	sequencia_digitada.append(numero)
	print("Sequência atual: ", sequencia_digitada)
	
	if sequencia_digitada.size() == SENHA_CORRETA.size():
		verificar_senha()

func verificar_senha() -> void:
	if sequencia_digitada == SENHA_CORRETA:
		print("Senha Correta!")
		
		var portas = get_tree().get_nodes_in_group("grupo_porta_da_caverna0")

		if portas.size() > 0:
			portas[0].abrir()
		
		tabletabertoAnimacao.visible = false
		sequencia_digitada.clear()
	else:
		print("Senha Incorreta! Tente novamente.")
		sequencia_digitada.clear()

		
	pass
