extends Area2D

var entrou = false
@onready var caverna_puzzle: StaticBody2D = $"../CavernaPuzzle"

func _on_body_entered(body: Node) -> void:	
	if body is CharacterBody2D:
		if entrou == false:
			caverna_puzzle.entry()
			entrou = true
		else:
			caverna_puzzle.exit()
			entrou = false


func _on_body_exited(body: Node2D) -> void:
	pass # Replace with function body.
