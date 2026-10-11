extends HSlider

@export var nome_audio_bus: String

var id_audio_bus: int

func _ready() -> void:
	id_audio_bus = AudioServer.get_bus_index(nome_audio_bus)

func _on_value_changed(value: float) -> void:
	var volume_db = linear_to_db(value)
	
	AudioServer.set_bus_volume_db(id_audio_bus, volume_db)
