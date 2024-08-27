class_name FPSOverlay
extends Control

@onready var fps_checkbox: CheckBox = $HBoxContainer/fps_checkbox as CheckBox
@onready var fp_slayer: CanvasLayer = $fps_overlay/FPSlayer


func _ready() -> void:
	fps_checkbox.toggled.connect(on_fps_checkbox_toggled)

#toggles fps layer on and off
func on_fps_checkbox_toggled(toggled_on: bool) -> void:
	if fp_slayer:
		fp_slayer.visible = toggled_on
		if toggled_on:
			$interfaceCheckedSFX.play()
			print("[SETTINGS > Accessibility] FPS Overlay ON!")
		else:
			$interfaceUncheckedSFX.play()
			print("[SETTINGS > Accessibility] FPS Overlay OFF!")
