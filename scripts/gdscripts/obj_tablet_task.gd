extends Node2D
@onready var interaction_area : InteractionArea = $InteractionArea
@onready var tableta_animation_player: AnimationPlayer = $tableta_animation_player
@onready var tela_animation_player: AnimationPlayer = $tela_animation_player
@onready var tela_sprite: Sprite2D = $InteractionArea/CanvasLayer/tableta_tela_sprite


func _ready() -> void:
	interaction_area.interact = Callable(self, "InteracaoTablet1")
	interaction_area.body_entered.connect(Callable(self, "_on_body_entered"))
	interaction_area.body_exited.connect(Callable(self, "_on_body_exited"))
	
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		tableta_animation_player.play_backwards("desligando")
		await tableta_animation_player.animation_finished
		tableta_animation_player.play("ligando")
		await tableta_animation_player.animation_finished
		tableta_animation_player.play("ligada")


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		tableta_animation_player.play("desligando")
		await tableta_animation_player.animation_finished
		tela_sprite.visible = false


func InteracaoTablet1():
	if tela_sprite.visible == false:
		tela_sprite.visible = true
		tela_animation_player.play("on_off")
		await tela_animation_player.animation_finished
		tela_animation_player.play("ligada")
	else:
		tela_sprite.visible = false
