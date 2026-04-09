class_name Gravity_Component
extends Node2D

@export var gravity_strength : float = 9.8
@export var influence_radius : float = 6.0
@export var draw_influence_circle : bool = false

# two constants to not make us write large numbers
const INFLUENCE_RADIUS_MULTIPLIER : float = 10**2
const GRAVITY_MULTIPLIER : float = 10**2

var entity : Node2D 

# just to make sure the entity exists
func setup(_entity : Node2D) -> void:
	entity = _entity

func get_gravity_at(particle_position : Vector2) -> Vector2:
	# creating a vector that points to the center in relation of the particle's position
	var vector_to_center : Vector2 = entity.global_position - particle_position
	
	# getting the module of the vector
	var distance : float = vector_to_center.length()
	
	if distance > influence_radius * INFLUENCE_RADIUS_MULTIPLIER:
		return Vector2.ZERO
	
	# get the direction of the center and strengthen it with the gravity_strength
	var gravity_force : Vector2 = vector_to_center.normalized() * gravity_strength * GRAVITY_MULTIPLIER
	return gravity_force

# function to debug/visualize the influence raidius. I gotta improve this function **
func _draw() -> void:
	if draw_influence_circle:
		draw_arc(Vector2.ZERO, influence_radius * INFLUENCE_RADIUS_MULTIPLIER, 0, TAU, 64, Color.RED, 2.0)
