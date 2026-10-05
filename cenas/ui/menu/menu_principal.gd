extends Control

var botoes: Array[TextureButton] = []

func _ready() -> void:
	for botao in $"Container-botao".get_children():
		if botao is not TextureButton: continue
		botao.disabled = true 
		botoes.append(botao)
		
	$AnimationPlayer.play("fade_out")

func _on_jogar_pressed() -> void:
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://cenas/jogo/main.tscn")

func _on_sair_pressed() -> void:
	await get_tree().process_frame
	get_tree().quit()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name != "fade_out": return
	for botao in botoes:
		botao.disabled = false
