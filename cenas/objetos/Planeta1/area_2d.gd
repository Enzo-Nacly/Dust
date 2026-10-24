extends Area2D

var dentro = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_player_entrou)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_player_entrou(body: Node2D) -> void:
	if body.is_in_group("player") or body.name == "Player":
		if !dentro:
			print("player Entrou")
			dentro = true
			for filho in get_children():
				filho.visible = false
		else:
			print("player saiu")
			dentro = false
			for filho in get_children():
				filho.visible = true
