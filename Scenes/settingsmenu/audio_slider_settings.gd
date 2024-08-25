extends Control

@onready var audio_name_label: Label = $HBoxContainer/audio_name_label as Label
@onready var audio_number_label: Label = $HBoxContainer/audio_number_label as Label
@onready var h_slider: HSlider = $HBoxContainer/HSlider as HSlider

# this will make customizations easiar as in the audio tab i have already 3 buses, and it will convert it to a string
@export_enum("Master", "Music", "SFX") var bus_name : String 

# as the start is 0, this will be considered as (MASTER)
var bus_index : int = 0

func _ready():
	h_slider.value_changed.connect(on_value_changed)
	get_bus_name_by_index()
	set_name_label_text()
	set_slider_value()

# simplifies the naming for volume as the bus name(MASTER/MUSIC/SFX) + Volume
func set_name_label_text() -> void:
	audio_name_label.text = str(bus_name) + " Volume "

# outputs the amount of value from the slider as a number
func set_audio_num_label_text() -> void:
	audio_number_label.text = str(h_slider.value * 100)
	
#calls the AudioServer(all audio from this application) based on the bus index @ line 11
func get_bus_name_by_index() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	
func set_slider_value() -> void:
	h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	set_audio_num_label_text()

func on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	print(bus_name, " Volume changed to ", str(h_slider.value * 100), "%") #debugs the audio val.
	set_audio_num_label_text()
