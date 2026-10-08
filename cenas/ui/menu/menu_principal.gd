extends Control

var botoes: Array[TextureButton] = []

var tempo: float = 0.0
var velocidade: float = 5.0
var amplitude: float = 3.0
var direcao: int = 1

func _ready() -> void:
	for botao in $"Container-botao".get_children():
		if botao is not TextureButton: continue
		botao.disabled = true 
		botoes.append(botao)
		
	$AnimationPlayer.play("fade_out")

func _process(delta: float) -> void:
	tempo += delta * velocidade * direcao
	

	if tempo >= TAU:
		tempo = TAU
		direcao = -1.0
		
	elif tempo <= 0.0:
		tempo = 0.0
		direcao = 1.0
		
	_movimento_sinoidal()

func _movimento_sinoidal() -> void:
	var corpos_celestes: Dictionary
	var amplitude_movimento: float = 0.2
	
	for corpos_celeste in $sistema_solar.get_children():
		corpos_celestes[corpos_celeste.name] = [corpos_celeste, amplitude_movimento]
	
	var posicao_y = remap(tempo, 0.0, TAU, -amplitude_movimento, amplitude_movimento)
	corpos_celestes["mercurio"][0].position.y += posicao_y

func _on_jogar_pressed() -> void:
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://cenas/jogo/main.tscn")

func _on_sair_pressed() -> void:
	await get_tree().process_frame
	get_tree().quit()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name != "fade_out": return
	
	for botao in botoes:
		botao.disabled = true
