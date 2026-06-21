extends Area2D

var entrou = true 
@onready var caverna_puzzle: StaticBody2D = $"../CavernaPuzzle"

func _ready() -> void:
	gerenciar_colisoes(true)

func _on_body_entered(body: Node) -> void:	
	if body is CharacterBody2D:
		if entrou == false:
			caverna_puzzle.exit()
			entrou = true
			gerenciar_colisoes(true)
		else:
			caverna_puzzle.entry()
			entrou = false
			gerenciar_colisoes(false)

func gerenciar_colisoes(desativar: bool) -> void:
	for filho in get_children():
		if filho is CollisionShape2D or filho is CollisionPolygon2D:
			continue
			
		for sub_filho in filho.get_children():
			if sub_filho is CollisionShape2D or sub_filho is CollisionPolygon2D:
				sub_filho.set_deferred("disabled", desativar)
				
			for SUB_sub_filho in sub_filho.get_children():
				if SUB_sub_filho is CollisionShape2D or SUB_sub_filho is CollisionPolygon2D:
					SUB_sub_filho.set_deferred("disabled", desativar)
