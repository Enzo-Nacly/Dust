extends Node2D

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var animacao: AnimationPlayer = $AnimationPlayer
@onready var icone: Sprite2D = $AnimationPlayer/Sprite2D  # ajuste o caminho se mover o Sprite2D

var active_areas = []
var can_interact = true
var area_atual: AreaInteracao = null

func _ready() -> void:
	icone.z_as_relative = false
	icone.z_index = 4096
	icone.hide()

func register_area(area: AreaInteracao):
	active_areas.push_back(area)

func unregister_area(area: AreaInteracao):
	var index = active_areas.find(area)
	if index != -1:
		active_areas.remove_at(index)

func _process(_delta):
	active_areas = active_areas.filter(func(a): return is_instance_valid(a))

	if active_areas.size() > 0 and can_interact:
		active_areas.sort_custom(_sort_by_distance_to_player)
		var area = active_areas[0]

		icone.global_position = area.global_position + area.global_transform.y * -50
		icone.global_rotation = area.global_rotation

		if area != area_atual or not icone.visible:
			area_atual = area
			
			
			
			icone.show()
			animacao.play("EInteracao")
	else:
		area_atual = null
		icone.hide()
		animacao.stop()

func _sort_by_distance_to_player(area1, area2):
	var d1 = player.global_position.distance_to(area1.global_position)
	var d2 = player.global_position.distance_to(area2.global_position)
	return d1 < d2

func _input(event):
	if event.is_action_pressed("interacao") and can_interact:
		if active_areas.size() > 0:
			var area = active_areas[0]
			can_interact = false
			icone.hide()
			animacao.stop()

			await area.interact.call()

			can_interact = true
