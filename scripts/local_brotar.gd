extends Node2D

@onready var interaction_area: AreaInteracao = $InteractionArea

func _ready() -> void:
	interaction_area.interact = Callable(self, "intracao_broto")

	interaction_area.body_entered.connect(_on_body_entered)
	interaction_area.body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	pass

func _on_body_exited(body: Node2D) -> void:
	pass

func intracao_broto() -> void:
	pass
