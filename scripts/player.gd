class_name Player
extends CharacterBody2D

@onready var movement_component : MovementComponent = $Components/Movement_Componet
@onready var rotation_component : Rotation_Component = $Components/Rotation_Component
@onready var jump_component : Jump_Component = $Components/Jump_Component
@onready var planet : Planet = get_tree().get_nodes_in_group("planets")[0]

func _ready() -> void:
	movement_component.setup(self)
	rotation_component.setup(self)
	jump_component.setup(self)
	

func _physics_process(delta: float) -> void:
	movement_component.move(delta)
	
	var gravity_force : Vector2 = planet.get_gravity_at(self.global_position)
	
	# if explorer isn't out of the planet
	if gravity_force != Vector2.ZERO:
		var vector_to_center: Vector2 = gravity_force.normalized()
		
		rotation_component.update_rotation(vector_to_center)
		
		# setting correctly the up_direction in relation to the planet
		self.up_direction = -vector_to_center
		# updating the motion_mode in order to not break the .is_on_floor() in jump_component
		self.motion_mode = CharacterBody2D.MOTION_MODE_GROUNDED
		jump_component.jump(vector_to_center)
		
		# aplying gravity to the entity
		self.velocity += gravity_force * delta
	else:
			# updating the motion_mode in order to not break the .is_on_floor() in jump_component
			self.motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	
	move_and_slide()
