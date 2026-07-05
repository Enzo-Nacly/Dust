extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var tableta_animation_player: AnimationPlayer = $tableta_animation_player
@onready var tela_animation_player: AnimationPlayer = $tela_animation_player
@onready var tela_sprite: Sprite2D = $InteractionArea/CanvasLayer/tableta_tela_sprite

var player_perto: bool = false


func _ready() -> void:
	interaction_area.interact = Callable(self, "InteracaoTablet1")

	interaction_area.body_entered.connect(_on_body_entered)
	interaction_area.body_exited.connect(_on_body_exited)

	tableta_animation_player.animation_finished.connect(_animacao_acabou)


func _animacao_acabou(animacao_nome: String) -> void:
	match animacao_nome:
		"ligando":
			if player_perto:
				tableta_animation_player.play("inicializar_tela")
			else:
				tableta_animation_player.play("desligando")
		"inicializar_tela":
			if player_perto:
				tableta_animation_player.play("ligada")
			else:
				tableta_animation_player.play("desligando")
		"desligando":
			pass


func _on_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return

	player_perto = true

	print("Player entrou")

	# Evita reiniciar a sequência caso ela já esteja ligada
	if tableta_animation_player.current_animation in [
		"ligando",
		"inicializar_tela",
		"ligada"
	]:
		return

	tableta_animation_player.play("ligando")


func _on_body_exited(body: Node2D) -> void:
	if body.name != "Player":
		return
	
	player_perto = false
	print("Player saiu")
	
	# Esconde a tela imediatamente
	tela_sprite.visible = false
	
	if tableta_animation_player.current_animation != "desligando":
		tableta_animation_player.play("desligando")


func InteracaoTablet1() -> void:
	if !player_perto:
		return

	if tableta_animation_player.current_animation != "ligada":
		return

	if !tela_sprite.visible:
		tela_sprite.visible = true
		tela_animation_player.play("on_off")

		await tela_animation_player.animation_finished

		tela_animation_player.play("ligada")
	else:
		tela_sprite.visible = false
