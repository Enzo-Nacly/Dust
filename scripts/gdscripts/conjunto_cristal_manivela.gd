extends StaticBody2D

@onready var interaction_area : InteractionArea = $InteractionArea

# [cristal_sprite, prato_sprite, suporte_sprite, manivela_sprite]
@onready var array_sprites : Array = $Sprites.get_children()

func _ready() -> void:
	interaction_area.interact = Callable(self, "girar_manivela")

#func _process(delta: float) -> void:
	#pass

func girar_manivela() -> void:
	array_sprites[3].scale.y *= -1
