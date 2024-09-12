extends Control

@onready var speednumber_label: Label = $HBoxContainer/speednumber_label
@onready var h_slider: HSlider = $HBoxContainer/HSlider


func _ready() -> void:
	h_slider.value_changed.connect(on_value_changed)
	#speednumber_label.value.connect(set_speednum_label_text)
	pass

# outputs the amount of value from the slider as a number
#func set_speednum_label_text(value: float) -> void:
	#speednumber_label.text = "%.2f" % h_slider.value
# nvm this func aint working, just needed to insert it to the func below :P

func on_value_changed(value: float) -> void:
	speednumber_label.text = "%.2f" % value # the output formats to 2 decimals
	Engine.time_scale = h_slider.value
	print("[SETTINGS > Accessibility] Game speed is now ", h_slider.value)
