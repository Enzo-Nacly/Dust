extends Area2D

const sistema_dialogo_preload = preload("res://cenas/ui/sistema_dialogo/sistema_dialogo.tscn")

@export var ativar_instantaneamente: bool
@export var ativar_one_shot: bool
@export var sobrepor_posicao_dialogo: bool
@export var posicao_sobreposicao: Vector2
@export var dialogo: Array[DialogoExport]

var posicao_encima_dialogo: Vector2 = Vector2(160, 48)
var posicao_embaixo_dialogo: Vector2 = Vector2(160, 192)

var player_dentro: bool = false
var ativou_ja: bool = false
var posicao_dialogo_desejada: Vector2

var player: Player = null

func _ready() -> void:
	for node in get_tree().get_nodes_in_group("player"):
		player = node

func _process(_delta: float) -> void:
	if !player:
		for node in get_tree().get_nodes_in_group("player"):
			player = node 
		return
	
	if !ativar_instantaneamente and player_dentro:
		if ativar_one_shot and ativou_ja:
			set_process(false)
			return
		
		if Input.is_action_just_pressed("ui_accept"):
			_ativar_dialogo()
			player_dentro = false

func _ativar_dialogo() -> void:
	Game_Manager.can_move = false
	
	var sistema_dialogo = sistema_dialogo_preload.instantiate()
	#if sobrepor_posicao_dialogo:
		#posicao_dialogo_desejada = posicao_sobreposicao
	#else:
		#if player.global_position.y > get_viewport().get_camera_2d().get_screen_center_position().y:
			#posicao_dialogo_desejada = posicao_encima_dialogo
		#else:
			#posicao_dialogo_desejada = posicao_embaixo_dialogo
	#sistema_dialogo.global_position = posicao_dialogo_desejada
	
	var ui: CanvasLayer = _pegar_camada_interface()
	if ui == null:
		printerr("Camada de interface, UI, não foi encontrada!!!")
		return
	ui.add_child(sistema_dialogo)
	
	sistema_dialogo.dialogo = dialogo
	ativou_ja = true
	#get_parent().add_child(sistema_dialogo)

func _pegar_camada_interface() -> CanvasLayer:
	return get_tree().get_first_node_in_group("ui") as CanvasLayer

func _on_body_entered(body: Node2D) -> void:
	if ativar_one_shot and ativou_ja:
		return
	if body.is_in_group("player"):
		player_dentro = true
		if ativar_instantaneamente:
			_ativar_dialogo()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_dentro = false
