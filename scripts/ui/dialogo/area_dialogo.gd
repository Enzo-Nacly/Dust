extends Area2D

const sistema_dialogo_preload = preload("res://cenas/ui/sistema_dialogo/sistema_dialogo.tscn")

@export var ativar_instantaneamente: bool
@export var ativar_one_shot: bool
@export var dialogo: Array[DialogoExport]

var player_dentro: bool = false
var ativou_ja: bool = false

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
	
	var ui: CanvasLayer = _pegar_camada_interface()
	if ui == null:
		printerr("Camada de interface, UI, não foi encontrada!!!")
		return
	ui.add_child(sistema_dialogo)
	sistema_dialogo.dialogo = dialogo
	
	ativou_ja = true

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
