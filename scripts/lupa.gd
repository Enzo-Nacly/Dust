extends Node2D

@onready var interaction_area : InteractionArea = $InteractionArea
@onready var luz: PointLight2D = $PointLight2D

var cores: Array[Color] = [Color.RED, Color.BLUE, Color.GREEN, Color.YELLOW]
var plantas : Array
var index_planta: int = 0

func _ready() -> void:
	plantas = get_tree().get_nodes_in_group("plantas")
	interaction_area.interact = Callable(self, "mudar_direcao")

#func _process(delta: float) -> void:
	#pass

func mudar_direcao() -> void:
	if plantas.is_empty():
		return

	index_planta += 1
	if index_planta >= plantas.size():
		index_planta = 0

	var planta := plantas[index_planta] as Node2D

	var direcao := planta.global_position - luz.global_position
	luz.rotation = direcao.angle() + deg_to_rad(55) + PI/2
	luz.color = cores[index_planta]
	
