extends StaticBody2D

@onready var caverna_puzzle: StaticBody2D = $"."
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var chao_varanda: ChaoVaranda = $"../ComponentEntryExit/ChaoVaranda"


func entry() ->void:
	var tween = create_tween()
	tween.tween_property(sprite_2d, "self_modulate:a", 0.0, 0.3)
	#chao_varanda.setup()

func exit() -> void:	
	var tween = create_tween()
	tween.tween_property(sprite_2d, "self_modulate:a", 1.0, 0.3)
	#chao_varanda.des_setup()
