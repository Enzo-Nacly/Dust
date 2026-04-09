class_name Planet
extends StaticBody2D

@onready var gravity_component : Gravity_Component = $Gravity_Component

func _ready() -> void:
	gravity_component.setup(self)

func get_gravity_at(particle_position : Vector2) -> Vector2:
	return gravity_component.get_gravity_at(particle_position)
