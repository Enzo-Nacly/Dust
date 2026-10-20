class_name Parede_externa
extends StaticBody2D


func exit() -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.3)

func entry() -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.3)
