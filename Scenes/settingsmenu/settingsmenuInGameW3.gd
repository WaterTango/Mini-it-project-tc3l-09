class_name  settingsmenuInGameW3
extends Control

@onready var backbutton: Button = $MarginContainer/VBoxContainer/backbutton as Button
@onready var settings_menu: Control = $"."
@onready var pause_menu: pausemenuW3 = $"../PauseMenu"

signal exit_settings_menu

func _ready() -> void:
	handle_connecting_settings_signals()
	
func handle_connecting_settings_signals() -> void:
	backbutton.button_down.connect(on_exit_pressed)
	set_process(false)

func on_exit_pressed() -> void:
	$clickSFX.play()
	exit_settings_menu.emit()
	settings_menu.visible = false
	pause_menu.visible = true
	set_process(false)
	print("[Pause Menu > Settings] Going back to Pause Menu...")
