extends Node2D

var fade_rect: ColorRect

func _enter_tree() -> void:
	## Troca a câmera o quanto antes, antes de qualquer frame renderizar
	$Player/Camera2D.enabled = false
	$AnimationPlayer/Camera2D.enabled = true
	$Player.visible = false
	$Player.set_physics_process(false)
	pass


func _ready() -> void:
	pass
	_criar_fade()
	
	#
	#
	$AnimationPlayer.play("CutsceneDescida")
	await $AnimationPlayer.animation_finished
	#
	await fade_out()
	$AnimationPlayer/Camera2D.enabled = false
	$Player/Camera2D.enabled = true
	$Player.visible = true
	await fade_in()
	#
	Game_Manager.out_dialog.emit()
	$Player.set_physics_process(true)


func _criar_fade() -> void:
	var layer := CanvasLayer.new()
	layer.layer = 10
	add_child(layer)
	
	fade_rect = ColorRect.new()
	fade_rect.color = Color(0, 0, 0, 0)
	fade_rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE  # <- importante
	layer.add_child(fade_rect)


func fade_out(duracao: float = 0.5) -> void:
	fade_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	var tween = create_tween()
	tween.tween_property(fade_rect, "color:a", 1.0, duracao)
	await tween.finished


func fade_in(duracao: float = 0.5) -> void:
	var tween = create_tween()
	tween.tween_property(fade_rect, "color:a", 0.0, duracao)
	await tween.finished
	fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE  # libera clique de novo
