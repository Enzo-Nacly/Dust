extends Node2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var tabletaberto: Sprite2D = $InteractionArea/CanvasLayer/Tabletaberto
var script_cs = load("res://assets/game/Control.cs")


func _ready() -> void:
	interaction_area.interact = Callable(self, "InteracaoTablet1")


func InteracaoTablet1():
	var instancia_cs = script_cs.new()
	
	if 	tabletaberto.visible == false:
		tabletaberto.visible = true
		instancia_cs.set("interacao", false)
	else:
		tabletaberto.visible = false
		instancia_cs.set("interacao", true)
