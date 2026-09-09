extends Control

var fade_rect: ColorRect

func _ready() -> void:

	$AnimationPlayer.play("intro")

func _on_jogar_pressed() -> void:
	_criar_fade()
	$AnimationPlayer.stop()
	$AnimationPlayer.play("cenaInicial")
	await $AnimationPlayer.animation_finished
	
	await fade_out()
	get_tree().change_scene_to_file("res://cenas/jogo/main.tscn")

func _on_sair_pressed() -> void:
	await get_tree().process_frame
	get_tree().quit()


func _criar_fade() -> void:
	var layer := CanvasLayer.new()
	layer.layer = 10
	add_child(layer)
	
	fade_rect = ColorRect.new()
	fade_rect.color = Color(0, 0, 0, 0)
	fade_rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	layer.add_child(fade_rect)


func fade_out(duracao: float = 0.5) -> void:
	var tween = create_tween()
	tween.tween_property(fade_rect, "color:a", 1.0, duracao)
	await tween.finished


func fade_in(duracao: float = 0.5) -> void:
	var tween = create_tween()
	tween.tween_property(fade_rect, "color:a", 0.0, duracao)
	await tween.finished
