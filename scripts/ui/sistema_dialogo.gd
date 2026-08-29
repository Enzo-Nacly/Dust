extends Node2D

const botao_dialogo_preload = preload("res://cenas/ui/sistema_dialogo/botao_dialogo.tscn")

@onready var label_dialogo: RichTextLabel = $HBoxContainer/VBoxContainer/RichTextLabel
@onready var sprite_falante: Sprite2D = $HBoxContainer/falante_pai/Sprite2D

var dialogo: Array[DialogoExport]
var item_dialogo_atual: int = 0
var proximo_item: bool = true

var player_node: Player

func _ready() -> void:
	self.visible = false
	$HBoxContainer/VBoxContainer/recipiente_botoes.visible = false
	
	for node in get_tree().get_nodes_in_group("player"):
		player_node = node

func _process(_delta: float) -> void:
	if item_dialogo_atual == dialogo.size():
		if !player_node:
			for node in get_tree().get_nodes_in_group("player"):
				player_node = node
			return
		Game_Manager.can_move = true
		queue_free()
		return
	if proximo_item:
		proximo_item = false
		var item = dialogo[item_dialogo_atual]
		
		if item is FuncaoDialogo:
			if item.esconder_caixa_dialogo:
				self.visible = false
			else:
				self.visible = true
			_funcao_resource(item)
		
		elif item is EscolhaDialogo:
			self.visible = true
			_escolha_resource(item)
			
		elif item is TextoDialogo:
			self.visible = true
			_texto_dialogo(item)
		
		else:
			printerr("Você adicionou a classe que não podia (DialogoExport)!!")
			item_dialogo_atual += 1
			proximo_item = true

func _funcao_resource(item: FuncaoDialogo) -> void:
	var node_com_funcao: Node = get_node(item.caminho_node_com_funcao)
	if node_com_funcao.has_method(item.nome_funcao):
		if item.parametros_funcao.size() == 0:
			node_com_funcao.call(item.nome_funcao)
		else:
			node_com_funcao.callv(item.nome_funcao, item.parametros_funcao)
	
	if item.esperar_sinal_para_continuar:
		var nome_sinal: String = item.esperar_sinal_para_continuar
		if node_com_funcao.has_signal(nome_sinal):
			#isso aqui é só porque funcoes lambda não conseguem editar valores de fora a não ser que seja um dicionário
			var estado_sinal = {"feito": false}
			var func_efeitoar: Callable = func(_args): estado_sinal.feito = true
			node_com_funcao.connect(nome_sinal, func_efeitoar, CONNECT_ONE_SHOT)
			while not estado_sinal.feito:
				#feito? -> não -> espera 1 frame -> feito? -> não -> ...
				await get_tree().process_frame
	
	item_dialogo_atual += 1
	proximo_item = true

func _escolha_resource(item: EscolhaDialogo) -> void:
	#seta o nome do falante aqui!! (se tiver né)
	label_dialogo.text = item.texto
	if item.imagem_falante:
		$HBoxContainer/falante_pai.visible = true
		sprite_falante.texture = item.imagem_falante
		sprite_falante.hframes = item.qtd_frames_falante
		sprite_falante.frame = min(item.frame_selecionada_falante, item.qtd_frames_falante - 1)
	else:
		$HBoxContainer/falante_pai.visible = false
	$HBoxContainer/VBoxContainer/recipiente_botoes.visible = true
	
	for elemento in item.texto_escolha.size():
		var botao_dialogo_variavel = botao_dialogo_preload.instantiate()
		botao_dialogo_variavel.text = item.texto_escolha[elemento]
		
		var funcao_resource: FuncaoDialogo = item.chamada_funcoes_escolha[elemento]
		if funcao_resource:
			botao_dialogo_variavel.connect(
				"pressed",
				Callable(get_node(funcao_resource.caminho_node_com_funcao),
						funcao_resource.nome_funcao).bindv(funcao_resource.parametros_funcao),
						CONNECT_ONE_SHOT)
			if funcao_resource.esconder_caixa_dialogo:
				botao_dialogo_variavel.connect("pressed", hide, CONNECT_ONE_SHOT)
			
			botao_dialogo_variavel.connect("pressed", _botao_escolha_pressionado.bind(get_node(funcao_resource.caminho_node_com_funcao),
			 funcao_resource.esperar_sinal_para_continuar), CONNECT_ONE_SHOT)
		else:
			botao_dialogo_variavel.connect("pressed", _botao_escolha_pressionado.bind(null, ""), CONNECT_ONE_SHOT)
		
		$HBoxContainer/VBoxContainer/recipiente_botoes.add_child(botao_dialogo_variavel)
	$HBoxContainer/VBoxContainer/recipiente_botoes.get_child(0).grab_focus()

func _botao_escolha_pressionado(node_com_funcao: Node, esperar_sinal_para_continuar: String) -> void:
	$HBoxContainer/VBoxContainer/recipiente_botoes.visible = false
	for botao in $HBoxContainer/VBoxContainer/recipiente_botoes.get_children():
		botao.queue_free()
	
	#dá pra pôr o audiostreamplayer do pressionamento do botao aqui no sistema de dialogo
	#e tocá-lo ele aqui
	
	if esperar_sinal_para_continuar:
		var nome_sinal: String = esperar_sinal_para_continuar
		if node_com_funcao.has_signal(nome_sinal):
			#isso aqui é só porque funcoes lambda não conseguem editar valores de fora a não ser que seja um dicionário
			var estado_sinal = {"feito": false}
			var func_efeitoar: Callable = func(_args): estado_sinal.feito = true
			node_com_funcao.connect(nome_sinal, func_efeitoar, CONNECT_ONE_SHOT)
			while not estado_sinal.feito:
				#feito? -> não -> espera 1 frame -> feito? -> não -> ...
				await get_tree().process_frame
	
	item_dialogo_atual += 1
	proximo_item = true

func _texto_dialogo(item: TextoDialogo) -> void:
	#dá pra setar o nome do falante aqui também
	$AudioStreamPlayer2D.stream = item.som_texto
	$AudioStreamPlayer2D.volume_db = item.volume_texto_db
	
	var camera: Camera2D = get_viewport().get_camera_2d()
	if camera and item.posicao_camera != Vector2(999.999, 999.999):
		var tween_camera: Tween = create_tween().set_trans(Tween.TRANS_SINE)
		tween_camera.tween_property(camera, "global_position", item.posicao_camera, item.tempo_transicao_camera)
	
	if !item.imagem_falante:
		$HBoxContainer/falante_pai.visible =  false
	else:
		$HBoxContainer/falante_pai.visible =  true
		sprite_falante.texture = item.imagem_falante
		sprite_falante.hframes = item.qtd_frames_falante
		sprite_falante.frame = 0
	
	label_dialogo.visible_characters = 0
	label_dialogo.text = item.texto
	var texto_sem_colchetes: String = _texto_sem_colchetes(item.texto)
	var total_caracteres: int = texto_sem_colchetes.length()
	var tempo_caracter: float = 0.0
	while label_dialogo.visible_characters < total_caracteres:
		if Input.is_action_just_pressed("ui_cancel"):
			label_dialogo.visible_characters = total_caracteres
			break
		
		tempo_caracter += get_process_delta_time()
		if tempo_caracter >= (1.0/item.velocidade_texto) or texto_sem_colchetes[label_dialogo.visible_characters] == " ":
			var caracter: String = texto_sem_colchetes[label_dialogo.visible_characters]
			label_dialogo.visible_characters += 1
			if caracter != " ":
				$AudioStreamPlayer2D.pitch_scale = randf_range(item.volume_texto_pitch_min, item.volume_texto_pitch_max)
				$AudioStreamPlayer2D.play()
				if item.qtd_frames_falante != 1:
					if sprite_falante.frame < item.qtd_frames_falante - 1:
						sprite_falante.frame += 1
					else:
						sprite_falante.frame = 0
			tempo_caracter = 0.0
		
		await get_tree().process_frame
	sprite_falante.frame = min(item.frame_falante_terminou, item.qtd_frames_falante - 1)
	
	while true:
		await get_tree().process_frame
		if label_dialogo.visible_characters == total_caracteres:
			if Input.is_action_just_pressed("ui_accept"):
				item_dialogo_atual += 1
				proximo_item = true

func _texto_sem_colchetes(texto: String) -> String:
	var resultado: String = ""
	var dentro_colchetes: bool = false
	
	for caracter in texto:
		if caracter == '[':
			dentro_colchetes = true
			continue
		
		if caracter == ']':
			dentro_colchetes = false
			continue
		
		if !dentro_colchetes:
			resultado += caracter
	
	return resultado
