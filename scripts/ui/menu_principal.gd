extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

var botoes: Array[Button] = []

func _ready() -> void:
	for botao in $"Container-botao".get_children():
		if botao is not Button: continue
		botao.disabled = true 
		botoes.append(botao)
	
	audio_stream_player.play()
	animation_player.play("fade_out")

func _on_jogar_pressed() -> void:
	await get_tree().process_frame
	
	animation_player.play("fade_in")
	await animation_player.animation_finished
	
	get_tree().change_scene_to_file("res://cenas/jogo/main.tscn")

func _on_sair_pressed() -> void:
	await get_tree().process_frame
	get_tree().quit()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out": 
		animation_player.play("fade_in_botoes")
	
	elif anim_name == "fade_in_botoes":
		for botao in botoes:
			botao.disabled = false
	


func _on_audio_stream_player_2d_finished() -> void:
	audio_stream_player.play()
