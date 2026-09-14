extends Node

@export var estado_inicial : State


var current_state : State 
var states : Dictionary = {}

func _ready() -> void:
	for child in get_children():
		states[child.name.to_lower()] = child
		child.Transicao.connect(on_child_transition)
	
	if estado_inicial:
		estado_inicial.Enter()
		current_state = estado_inicial	
		
func _process(delta):
	if current_state:
		current_state.Update(delta)
		
func _physics_process(delta):
	if current_state:
		current_state.Update(delta)
	
func on_child_transition(state, new_state_name):
	if state != current_state:
		return
		
	var new_state = state.get(new_state_name.to_lower())
	if !new_state:
		return
		
	if current_state:
		current_state.exit()
	
	current_state.enter()
	current_state = new_state
	
