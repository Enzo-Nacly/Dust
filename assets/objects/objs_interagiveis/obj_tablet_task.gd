extends Node2D
@onready var interaction_area : InteractionArea = $InteractionArea
@onready var animacao: AnimatedSprite2D = $AnimatedSprite2D
@onready var tabletabertoAnimacao : AnimatedSprite2D = $InteractionArea/CanvasLayer/AnimacaoSprTabletAberto
@onready var tabletaberto: Sprite2D = $InteractionArea/CanvasLayer/Tabletaberto
var script_cs = load("res://assets/game/Control.cs")

func _ready() -> void:
	interaction_area.interact = Callable(self, "InteracaoTablet1")
	interaction_area.body_entered.connect(Callable(self, "_on_body_entered"))
	interaction_area.body_exited.connect(Callable(self, "_on_body_exited"))
	animacao.play("TabletDesligando")
	animacao.stop()
	animacao.frame = 4;
	
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		animacao.play("PlacaFuncionando")
		await animacao.animation_finished
		if animacao.animation == "PlacaFuncionando":
			animacao.play("TabletLigado")

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		tabletabertoAnimacao.visible = false
		animacao.play("TabletDesligando")
		await animacao.animation_finished
		if animacao.animation == "TabletDesligando":
			animacao.stop()
			animacao.frame = 4


func _process(delta: float) -> void:
	pass

func InteracaoTablet1():
	var instancia_cs = script_cs.new()
	tabletabertoAnimacao.play()
	if tabletabertoAnimacao.visible == false:
		tabletabertoAnimacao.visible = true
		instancia_cs.set("interacao", false)
	else:
		tabletabertoAnimacao.visible = false
		instancia_cs.set("interacao", true)
