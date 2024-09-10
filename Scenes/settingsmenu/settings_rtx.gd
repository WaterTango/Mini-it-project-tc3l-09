class_name rtxon
extends Control

@onready var rtx_checkbox: CheckBox = $HBoxContainer/rtx_checkbox as CheckBox
#@onready var shadow: Node = $shadow as Node

func _ready() -> void:
	rtx_checkbox.toggled.connect(on_rtx_checkbox_toggled)

func on_rtx_checkbox_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$interfaceCheckedSFX.play()
		#shadow.visibility = true
		print("[SETTINGS > Accessibility] RTX is OOOOOOOOOON!")
	else:
		$interfaceUncheckedSFX.play()
		#shadow.visibility = false
		print("[SETTINGS > Accessibility] RTX JUST TURNED OFF!")
