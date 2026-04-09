class_name Jump_Component
extends Node2D

@export var jump_force : float = 400.0

var entity : CharacterBody2D

# just to make sure the entity exists
func setup(_entity : CharacterBody2D) -> void:
	entity = _entity

func jump(vector_to_center : Vector2) -> void:
	var jumped : float = Input.is_action_just_pressed("ui_accept")
	var on_floor : bool = entity.is_on_floor()
	
	if jumped and on_floor:
		entity.velocity -= vector_to_center * jump_force
