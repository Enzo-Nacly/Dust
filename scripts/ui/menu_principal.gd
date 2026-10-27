extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var panel_opcoes: Panel = $panel_opcoes

var botoes: Array[Button] = []

func _ready() -> void:
	$ColorRect.visible = true
	
	for botao in $"Container-botao".get_children():
		if botao is not Button: continue
		botoes.append(botao)
	
	_desabilitar_botoes(true)
	
	panel_opcoes.visible = false
	panel_opcoes.scale = Vector2.ZERO
	
	audio_stream_player.play()
	animation_player.play("fade_out")

func _on_jogar_pressed() -> void:
	_desabilitar_botoes(true)
	
	await get_tree().process_frame
	
	animation_player.play("fade_in")
	await animation_player.animation_finished
	
	if is_inside_tree() and get_tree() != null:
		animation_player.play("cena1")
		await animation_player.animation_finished
		get_tree().change_scene_to_file("res://cenas/jogo/main.tscn")

func _on_sair_pressed() -> void:
	await get_tree().process_frame
	get_tree().quit()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out": 
		animation_player.play("fade_in_botoes")
	
	elif anim_name == "fade_in_botoes":
		$Titulo.clicavel = true
		_desabilitar_botoes(false)
	
	$"Container-botao/jogar".grab_focus()

func _on_audio_stream_player_2d_finished() -> void:
	audio_stream_player.play()

func _desabilitar_botoes(valor: bool) -> void:
	for botao in botoes:
		botao.disabled = valor 

func _on_opcoes_pressed() -> void:
	_desabilitar_botoes(true)
	
	panel_opcoes.pivot_offset = panel_opcoes.size / 2
	
	panel_opcoes.scale = Vector2.ZERO
	panel_opcoes.visible = true
	
	var tween_surgimento: Tween = create_tween()
	var duracao: float = 0.15
	tween_surgimento.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween_surgimento.tween_property(panel_opcoes, "scale", Vector2.ONE, duracao)

func _on_voltar_pressed() -> void:
	var tween_desaparecimento: Tween = create_tween()
	var duracao: float = 0.15
	tween_desaparecimento.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	tween_desaparecimento.tween_property(panel_opcoes, "scale", Vector2.ZERO, duracao)
	
	await tween_desaparecimento.finished
	panel_opcoes.visible = false
	_desabilitar_botoes(false)
	
	$"Container-botao/opcoes".grab_focus()
