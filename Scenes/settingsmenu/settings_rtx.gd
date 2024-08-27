class_name rtxon
extends Control

@onready var rtx_checkbox: CheckBox = $HBoxContainer/rtx_checkbox as CheckBox

func _ready() -> void:
	rtx_checkbox.toggled.connect(on_rtx_checkbox_toggled)

func on_rtx_checkbox_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$interfaceCheckedSFX.play()
		print("[SETTINGS > Accessibility] RTX is OOOOOOOOOON!")
	else:
		$interfaceUncheckedSFX.play()
		print("[SETTINGS > Accessibility] RTX JUST TURNED OFF!")
