class_name Player
extends CharacterBody2D

@onready var movement_component : MovementComponent = $Components/Movement
#@onready var
#@onready var
#@onready var

func _ready() -> void:
	movement_component.setup(self)

func _physics_process(delta: float) -> void:
	movement_component.run(delta)
	
	move_and_slide()
