extends Area2D
class_name Entrada

@onready var camera: Camera2D = $Camera2D 
var dentro = false
var tween: Tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera.enabled = false
	body_entered.connect(_on_player_entrou)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_player_entrou(body: Node2D) -> void:
	if body.is_in_group("player") or body.name == "Player":
		
		if tween: tween.kill()
		tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
		dentro = !dentro
		
		if dentro:
			camera.enabled = true
			camera.make_current()

			print("Player Entrou")
			tween.tween_property(self, "modulate:a", 0.0, 0.5)
		else:
			print("Player Saiu")
			camera.enabled = false
			camera.make_current()
			tween.tween_property(self, "modulate:a", 1.0, 0.5)
					
