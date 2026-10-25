extends Area2D
class_name Entrada

@export var anterior: Entrada

@onready var camera: Camera2D = $Camera2D 
var dentro = false
var tween: Tween

func _ready() -> void:
	camera.enabled = false
	body_entered.connect(_on_player_entrou)
	alternar_colisoes_vizinhas(true)

func _on_player_entrou(body: Node2D) -> void:
	if body.is_in_group("player") or body.name == "Player":
		
		if tween: tween.kill()
		tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
		dentro = !dentro
		
		if dentro:
			camera.enabled = true
			camera.make_current()

			print("Player Entrou")
			tween.tween_property(self, "modulate:a", 0.0, 0.5)
			
			aplicar_colisoes_de_entrada()
		else:
			print("Player Saiu")
			camera.enabled = false
			camera.make_current()
			tween.tween_property(self, "modulate:a", 1.0, 0.5)
			
			alternar_colisoes_vizinhas(true)
			
			if anterior:
				alternar_colisoes_descendentes(false)
				anterior.aplicar_colisoes_de_entrada()
			else:
				alternar_colisoes_descendentes(true)

func aplicar_colisoes_de_entrada() -> void:
	alternar_colisoes_vizinhas(false)
	alternar_colisoes_descendentes(true)

func alternar_colisoes_vizinhas(deve_desativar: bool) -> void:
	var nos_para_checar: Array = []
	
	for irmao in get_parent().get_children():
		if irmao != self:
			nos_para_checar.append(irmao)
	
	_aplicar(nos_para_checar, deve_desativar)

func alternar_colisoes_descendentes(deve_desativar: bool) -> void:
	var nos_para_checar: Array = []
	
	for filho in get_children():
		if filho is CollisionShape2D or filho is CollisionPolygon2D:
			continue
		nos_para_checar.append(filho)
	
	_aplicar(nos_para_checar, deve_desativar)

func _aplicar(nos_para_checar: Array, deve_desativar: bool) -> void:
	while nos_para_checar.size() > 0:
		var no_atual = nos_para_checar.pop_front()
		
		if no_atual is CollisionShape2D or no_atual is CollisionPolygon2D:
			no_atual.set_deferred("disabled", deve_desativar)
		
		for filho in no_atual.get_children():
			nos_para_checar.append(filho)
