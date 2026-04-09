class_name Rotation_Component
extends Node2D

var entity : Node2D

# just to make sure the entity exists
func setup(_entity : Node2D) -> void:
	entity = _entity
	
# rotating the entity to the center
func update_rotation(vector_to_center : Vector2) -> void:
	entity.rotation = vector_to_center.angle() - PI/2
