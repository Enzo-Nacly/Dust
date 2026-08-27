extends Control

func _ready() -> void:
	$AnimationPlayer.play("intro")

func _on_jogar_pressed() -> void:
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://cenas/jogo/main.tscn")

func _on_sair_pressed() -> void:
	await get_tree().process_frame
	get_tree().quit()
