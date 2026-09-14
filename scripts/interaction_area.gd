class_name AreaInteracao
extends Area2D

@export var action_name: String = "interact"

var interact: Callable = func():
	pass


func _on_body_entered(_body: Node2D) -> void:
	GerenciadorInteracao.register_area(self)

func _on_body_exited(_body: Node2D) -> void:
	GerenciadorInteracao.unregister_area(self)
